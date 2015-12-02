print('IntelliDust Speck kernel started')

dofile("config.lc")
print('Config loaded.')

log_debug = nil
function log_debug(message)
  if cfg.debug==1 then
        print("DEBUG: ",message) 
  end
end

print('Core API ready.')

print('Initialising services')

dofile("service-00-garbage.lc")

print('Services started')
