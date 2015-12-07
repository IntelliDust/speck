local http_server_name=cfg.s.sv.."Speck"

function validateMethod(method)
--   local httpMethods = {GET=true, HEAD=true, POST=true, PUT=true, DELETE=true, TRACE=true, OPTIONS=true, CONNECT=true, PATCH=true}
   local httpMethods = {GET=true, HEAD=true, POST=true, OPTIONS=true, CONNECT=true}
   return httpMethods[method]
end
function uriToFilename(u)
   return "http-" .. string.sub(u, 2, -1)
end

function getrDt(pld)
  local rDt
  return function ()
    if rDt then
      return rDt
    else
      local mimeType = string.match(pld, "Content%-Type: (%S+)\r\n")
      local body_start = pld:find("\r\n\r\n", 1, true)
      local body = pld:sub(body_start, #payload)
      pld = nil
      cg()
      if mimeType == "application/".."json" then
        print("JSON: " .. body)
        rDt = cjson.decode(body)
      elseif mimeType == "application/".."x-www-form-urlencoded" then
        rDt = parseFormData(body)
      else
        rDt = {}
      end
      return rDt
    end
  end
end

function parseUri(uri)
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
function parse_http_request(request)
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
function core_httpserver_header(connection, code, extension, gzip)
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
