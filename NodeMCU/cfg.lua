hp()
cfg={}
cfg.dbg=1
cfg.v="0.0.1"
cfg.gcr=60

dofile("cfg-st.lc") 
--dofile("cfg-i2c.lc")	    -- I2C config (compiled)
dofile("cfg-gpio.lc") 
dofile("cfg-brm.lc")	    -- IntelliDust BROOM config (not compiled because it's possible to be online changed)
dofile("cfg-wf.lc")	    -- WiFi config (not compiled because it's possible to be online changed)
--dofile("cfg-http.lc")	    -- HTTP Daemon config (not compiled because it's possible to be online changed)
--dofile("cfg-mmqt.lc")	    -- MMQT Client config (not compiled because it's possible to be online changed)
