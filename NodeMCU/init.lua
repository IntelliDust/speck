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

local SpeckFiles = {'kernel.lua', 'svc00-gbc.lua', 'svc01-cr.lua', 'svc02-wf.lua', 'svc08-httpd.lua', 'core-httpserver.lua','core-httpserver-utils.lua', }
for i, f in ipairs(SpeckFiles) do compileAndRemoveIfNeeded(f,1) end

print('Compiling LUA config files')
local ConfigFiles = {'cfg.lua', 'cfg-brm.lua', 'cfg-http.lua', 'cfg-i2c.lua', 'cfg-mmqt.lua', 'cfg-st.lua', 'cfg-wf.lua' }
for i, f in ipairs(ConfigFiles) do compileAndRemoveIfNeeded(f,0) end

compileAndRemoveIfNeeded = nil
SpeckFiles = nil
ConfigFiles = nil
collectgarbage()

dofile("kernel.lc")
