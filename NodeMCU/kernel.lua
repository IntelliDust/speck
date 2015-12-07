hp()
print('IntelliDust Speck')

dofile("config.lc")
print('Config loaded.')

log_debug = nil
function log_debug(message)
  if cfg.dbg==1 then
        print("DEBUG: ",message) 
  end
end
hp()

-- print('Core API ready.')

print("Kernel".." GO")

dofile("service-00-garbage.lc")
--dofile("service-01-core.lc")
dofile("service-02-wifi.lc")
--dofile('service-08-httpd.lc')

print("Kernel".." DN")
hp()
