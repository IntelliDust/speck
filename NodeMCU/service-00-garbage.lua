hp()
cg=collectgarbage()
if cfg.gcr>0 then
  tmr.alarm(1, cfg.gcr*1000, 1, function() 
    cg()
    hp()
  end )
end
print(cfg.s.sv..": CG DN("..cfg.gcr.." s.)")
