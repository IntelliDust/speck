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
dofile("service-01-core.lc")
dofile("service-02-wifi.lc")
dofile('service-08-httpd.lc')

print('Services started')
