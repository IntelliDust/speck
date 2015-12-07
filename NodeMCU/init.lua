-- uart.setup(0,115200,8,0,1)
-- tmr.delay(250)
-- print('Changing UART speed to 115200')
print('Speeding CPU160MHZ')
node.setcpufreq(node.CPU160MHZ) 

hp = function()
  print('Heap=',node.heap())
end

hp()

print('IntelliDust Speck loading')

print('Compiling LUA files')

local compileAndRemoveIfNeeded = function(f,x)
   if file.open(f) then
      file.close()
      print(' Compiling:', f)
      node.compile(f)
      if x==1 then
         file.remove(f)
      end
      collectgarbage()
      hp()
   end
end

local SpeckFiles = {'kernel.lua', 'service-00-garbage.lua', 'service-01-core.lua', 'service-02-wifi.lua', 'service-08-httpd.lua', 'core-httpserver.lua', 'core-httpserver-basicauth.lua', 'core-httpserver-conf.lua', 'core-httpserver-b64decode.lua', 'core-httpserver-request.lua', 'core-httpserver-static.lua', 'core-httpserver-header.lua', 'core-httpserver-error.lua'}
for i, f in ipairs(SpeckFiles) do compileAndRemoveIfNeeded(f,1) end

print('Compiling LUA config files')
local ConfigFiles = {'config.lua', 'config-broom.lua', 'config-http.lua', 'config-i2c.lua', 'config-mmqt.lua', 'config-strings.lua', 'config-wifi.lua' }
for i, f in ipairs(ConfigFiles) do compileAndRemoveIfNeeded(f,0) end

compileAndRemoveIfNeeded = nil
SpeckFiles = nil
ConfigFiles = nil
collectgarbage()

dofile("kernel.lc")
