cfg={}
cfg.debug=0
cfg.version="0.0.1"
cfg.garbage_collector_refresh=30

dofile("config-i2c.lc")		-- I2C config (compiled)
dofile("config-broom.lua")	-- IntelliDust BROOM config (not compiled because it's possible to be online changed)
dofile("config-wifi.lua")	-- WiFi config (not compiled because it's possible to be online changed)
dofile("config-http.lua")	-- HTTP Daemon config (not compiled because it's possible to be online changed)
dofile("config-mmqt.lua")	-- MMQT Client config (not compiled because it's possible to be online changed)
