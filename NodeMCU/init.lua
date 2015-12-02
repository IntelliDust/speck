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

local SpeckFiles = {'config.lua', 'kernel.lua'}
for i, f in ipairs(SpeckFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
SpeckFiles = nil

dofile("kernel.lc")