hp()
cfg={}
cfg.dbg=1
cfg.v="0.0.1"
cfg.gcr=60

dofile("config-strings.lc") 
--dofile("config-i2c.lc")	    -- I2C config (compiled)
dofile("config-broom.lc")	    -- IntelliDust BROOM config (not compiled because it's possible to be online changed)
dofile("config-wifi.lc")	    -- WiFi config (not compiled because it's possible to be online changed)
--dofile("config-http.lc")	    -- HTTP Daemon config (not compiled because it's possible to be online changed)
--dofile("config-mmqt.lc")	    -- MMQT Client config (not compiled because it's possible to be online changed)
