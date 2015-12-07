hp()
if cfg.gcr>0 then
  tmr.alarm(1, cfg.gcr*1000, 1, function() 
    collectgarbage()
    hp()
  end )
end
print(cfg.s.sv..": CG DN("..cfg.gcr.." s.)")
