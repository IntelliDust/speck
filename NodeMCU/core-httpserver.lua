return function (port)

local http_server_name=cfg.s.sv.."Speck"

local function validateMethod(method)
--   local httpMethods = {GET=true, HEAD=true, POST=true, PUT=true, DELETE=true, TRACE=true, OPTIONS=true, CONNECT=true, PATCH=true}
   local httpMethods = {GET=true, HEAD=true, POST=true, OPTIONS=true, CONNECT=true}
   return httpMethods[method]
end
local function uriToFilename(u)
   return "http-" .. string.sub(u, 2, -1)
end

local function getrDt(payload)
  local rDt
  return function ()
    if rDt then
      return rDt
    else
      local mimeType = string.match(payload, "Content%-Type: (%S+)\r\n")
      local body_start = payload:find("\r\n\r\n", 1, true)
      local body = payload:sub(body_start, #payload)
      payload = nil
      collectgarbage()
      if mimeType == "application".."/json" then
        print("JSON: " .. body)
        rDt = cjson.decode(body)
      elseif mimeType == "application".."x-www-form-urlencoded" then
        rDt = parseFormData(body)
      else
        rDt = {}
      end
      return rDt
    end
  end
end
local function parseUri(uri)
   local r = {}
   local filename
   local ext
   local fullExt = {}
   if uri == nil then return r end
   if uri == "/" then uri = "/index.html" end
   questionMarkPos, b, c, d, e, f = uri:find("?")
   if questionMarkPos == nil then
      r.file = uri:sub(1, questionMarkPos)
      r.args = {}
   else
      r.file = uri:sub(1, questionMarkPos - 1)
      r.args = parseArgs(uri:sub(questionMarkPos+1, #uri))
   end
   filename = r.file
   while filename:match("%.") do
      filename,ext = filename:match("(.+)%.(.+)")
      table.insert(fullExt,1,ext)
   end
   if #fullExt > 1 and fullExt[#fullExt] == 'gz' then
      r.ext = fullExt[#fullExt-1]
      r.isGzipped = true
   elseif #fullExt >= 1 then
      r.ext = fullExt[#fullExt]
   end
   r.isScript = r.ext == "lua" or r.ext == "lc"
   r.file = uriToFilename(r.file)
   return r
end
local function parse_http_request(request)
   local e = request:find("\r\n", 1, true)
   if not e then return nil end
   local line = request:sub(1, e - 1)
   local r = {}
   _, i, r.method, r.request = line:find("^([A-Z]+) (.-) HTTP/[1-9]+.[0-9]+$")
   r.methodIsValid = validateMethod(r.method)
   r.uri = parseUri(r.request)
   r.getrDt = getrDt(request)
   return r
end
-- END: core-httpserver-request
local function core_httpserver_static(connection, req, args)
local core_httpserver_header = function (connection, code, extension, gzip)
   local function getHTTPStatusString(code)
      local codez = {[200]="OK", [400]="Bad Request", [404]="Not Found",}
      local myResult = codez[code]
      if myResult then return myResult else return "Not Implemented" end
   end
   local function getMimeType(ext)
      local gzip = false
      local mt = {css = "text/".."css", gif = "image/".."gif", html = "text/".."html", ico = "image/".."x-icon", jpeg = "image/".."jpeg", jpg = "image/".."jpeg", js = "application/".."javascript", 
		  json = "application/".."json", png = "image/".."png", xml = "text/".."xml"}
      if mt[ext] then contentType = mt[ext] else contentType = "text/".."plain" end
      return {contentType = contentType, gzip = gzip}
   end
   local mimeType = getMimeType(extension)
   connection:send("HTTP/1.0 " .. code .. " " .. getHTTPStatusString(code) .. "\r\nServer: nodemcu-httpserver\r\nContent-Type: " .. mimeType["contentType"] .. "\r\n")
   if gzip then
       connection:send("Cache-Control: max-age=2592000\r\n")
       connection:send("Content-Encoding: gzip\r\n")
   end
   connection:send("Connection: close\r\n\r\n")
end
local function core_httpserver_static(connection, req, args)
   core_httpserver_header(connection, 200, args.ext, args.gzipped)
   print("HEAP "..node.heap().." bytes")
   local continue = true
   local bytesSent = 0
   while continue do
      collectgarbage()
      print("HEAP "..node.heap().." bytes")
      file.open(args.file)
      file.seek("set", bytesSent)
      local chunk = file.read(256)
      file.close()
      if chunk == nil then
         continue = false
      else
         connection:send(chunk)
         bytesSent = bytesSent + #chunk
         chunk = nil
         print("Sent " .. args.file, bytesSent)
         tmr.wdclr()
      end
   end
     print("Finished sending:", args.file)
end
local function handle_http_error(connection, req, args)
   local function sendHeader(connection, code, errorString, extraHeaders, mimeType)
      connection:send("HTTP/1.0 " .. code .. " " .. errorString .. "\r\nServer: "..http_server_name.."\r\nContent-Type: " .. mimeType .. "\r\n")
      for i, header in ipairs(extraHeaders) do
         connection:send(header .. "\r\n")
      end 
      connection:send("connection: close\r\n\r\n")
   end
   print("Error " .. args.code .. ": " .. args.errorString)
   args.headers = args.headers or {}
   sendHeader(connection, args.code, args.errorString, args.headers, "text/html")
   connection:send("<html><head><title>" .. args.code .. " - " .. args.errorString .. "</title></head><body><h1>" .. args.code .. " - " .. args.errorString .. "</h1></body></html>\r\n")
end
   local function onRequest(con, req)
        print((tmr.now()/1000/100).." onRequest started ")
	if not con then 
           print((tmr.now()/1000/100).." connection is nil ")
	   return nil 
	end;
        local method = req.method
        local uri = req.uri
            
        print("Method: " .. method);
        print("uri.file: " .. uri.file);
        if #(uri.file) > 32 then
          print("TL FN: " .. #(uri.file)); -- too long filename
          local args = {}
          args = {code = 400, errorString = "BadReq"}
          handle_http_error(con, req, args)
	else
          print((tmr.now()/1000/100).." handling filename: " .. uri.file);
               local fileExists = file.open(uri.file, "r")
               file.close()
               if not fileExists then
                 -- gzip check
                 fileExists = file.open(uri.file .. ".gz", "r")
                 file.close()

                 if fileExists then
                    print("gzip exist")
                    uri.file = uri.file .. ".gz"
                    uri.isGzipped = true
                 end
               end

               if not fileExists then
          	  local args = {}
                  args = {code = 404, errorString = "Not Found"}
                  handle_http_error(con, req, args)
               elseif uri.isScript then
--                  fileServeFunction = dofile(uri.file)
               else
    	  	  con:send("<h1> Hello, NodeMCU!!! </h1>")
               end
    	end
   end

   local function http_recieve(connection,request)
        collectgarbage()
        print((tmr.now()/1000/100).." onReceive")
	
	local req = parse_http_request(request)
        print((tmr.now()/1000/100).." Requested URI: " .. req.request)

        if req.methodIsValid and (req.method == "GET" or req.method == "POST" or req.method == "PUT") then
           onRequest(connection, req)
        else
           local args = {}
           if req.methodIsValid then
              args = {code = 501, errorString = "N.Impl"}
           else
              args = {code = 400, errorString = "B.Req"}
           end
           handle_http_error(connection, req, args)
        end
        connection:close()
   end

   local ConnectionHandler = function (connection)
	connection:on("receive",http_recieve)
   end

   local http_server = net.createServer(net.TCP, 10) -- 10 seconds client timeout
   http_server:listen(port,ConnectionHandler)

   local ip = wifi.sta.getip()
   if not ip then ip = wifi.ap.getip() end
   print("IntelliDust http_server running at http://" .. ip .. ":" ..  port)
   return http_server

end
