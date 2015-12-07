cfg.wifi={}
cfg.wifi.m = 2			-- wifi.STATIONAP

cfg.wifi.a={}                   -- Station cgf
cfg.wifi.a.r={}
cfg.wifi.a.r.ssid=cfg.s.s.. wifi.ap.getmac():gsub(":",""):upper()
cfg.wifi.a.r.pwd="12345678"

cfg.wifi.a.n={}
cfg.wifi.a.n.ip="192.168.111.1"
cfg.wifi.a.n.netmask="255.255.255.0"
cfg.wifi.a.n.gw=cfg.wifi.a.n.ip -- "0.0.0.0" -- "192.168.111.1"

cfg.wifi.s={}			-- Station cgf
cfg.wifi.s.m=0                  -- mode
-- 0=fixed one configured in cfg.wifi.sta
-- 1=one of known configured in cfg.wifi.known_ap
-- 2=one of X (best signal of free wifi)
cfg.wifi.s.s="Internet0"	-- ssid
cfg.wifi.s.p="Internet0"        -- passwd

cfg.wifi.ka={}  		-- known ap
cfg.wifi.ka[1]={}               
cfg.wifi.ka[1].s="Internet1"    -- ssid
cfg.wifi.ka[1].p="password1"    -- passwd
cfg.wifi.ka[2]={}
cfg.wifi.ka[2].s="Internet2"    -- ssid
cfg.wifi.ka[2].p="password2"    -- passwd
