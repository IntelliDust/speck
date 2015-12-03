print('Changing UART speed to 115200')
uart.setup(0,115200,8,0,1)
print('Speeding CPU160MHZ')
node.setcpufreq(node.CPU160MHZ) 
print('Heap=',node.heap())
print('IntelliDust Speck loading')

print('Compiling LUA files')

local compileAndRemoveIfNeeded = function(f)
   if file.open(f) then
      file.close()
      print(' Compiling:', f)
      node.compile(f)
      file.remove(f)
      collectgarbage()
   end
end

local SpeckFiles = {'config.lua', 'kernel.lua', 'service-00-garbage.lua', 'service-01-core.lua', 'service-02-wifi.lua', 'service-08-httpd.lua', 'core-httpserver.lua', 'core-httpserver-basicauth.lua', 'core-httpserver-conf.lua', 'core-httpserver-b64decode.lua', 'core-httpserver-request.lua', 'core-httpserver-static.lua', 'core-httpserver-header.lua', 'core-httpserver-error.lua'}
for i, f in ipairs(SpeckFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
SpeckFiles = nil
collectgarbage()

dofile("kernel.lc")
