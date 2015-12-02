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

local SpeckFiles = {'config.lua', 'config-i2c.lua', 'kernel.lua', 'service-00-garbage.lua', 'service-01-core.lua', 'service-02-wifi.lua'}
for i, f in ipairs(SpeckFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
SpeckFiles = nil
collectgarbage()

dofile("kernel.lc")
