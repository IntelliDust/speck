if cfg.garbage_collector_refresh>0 then
  tmr.alarm(0, cfg.garbage_collector_refresh*1000, 1, function() 
    collectgarbage()
    log_debug("Garbage collector daemon - HEAP "..node.heap().." bytes")
  end )
end
print("Service: Garbage collector initialised for every "..cfg.garbage_collector_refresh.." seconds")
