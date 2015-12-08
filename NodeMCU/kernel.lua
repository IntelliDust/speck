hp()
print('IntelliDust Speck')
dofile("cfg.lc")
log_debug = nil
function log_debug(message)
  if cfg.dbg==1 then
        print("DEBUG: ",message) 
  end
end
hp()
print("Kernel".." GO")

dofile("svc00-gbc.lc")
dofile("svc01-cr.lc")
dofile("svc02-wf.lc")
--dofile('service-08-httpd.lc')

print("Kernel".." DN")
hp()
