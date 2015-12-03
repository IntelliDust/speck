cfg.wifi={}
cfg.wifi.mode = wifi.STATIONAP

cfg.wifi.ap={}
cfg.wifi.ap.rf={}
cfg.wifi.ap.rf.ssid="IntelliDust-" .. wifi.ap.getmac():gsub(":",""):upper()
cfg.wifi.ap.rf.pwd="12345678"

cfg.wifi.ap.net={}
cfg.wifi.ap.net.ip="192.168.111.1"
cfg.wifi.ap.net.netmask="255.255.255.0"
cfg.wifi.ap.net.gw="0.0.0.0" -- "192.168.111.1"

cfg.wifi.sta={}
cfg.wifi.sta.mode=0
-- 0=fixed one configured in cfg.wifi.sta
-- 1=one of known configured in cfg.wifi.known_ap
-- 2=one of X (best signal of free wifi)
cfg.wifi.sta.ssid="Internet0"
cfg.wifi.sta.pwd="Internet0"

cfg.wifi.known_ap={}
cfg.wifi.known_ap[1]={}
cfg.wifi.known_ap[1].ssid="Internet1"
cfg.wifi.known_ap[1].pwd="password1"
cfg.wifi.known_ap[2]={}
cfg.wifi.known_ap[2].ssid="Internet2"
cfg.wifi.known_ap[2].pwd="password2"
