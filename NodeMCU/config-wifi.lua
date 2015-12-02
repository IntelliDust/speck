cfg.wifi={}
cfg.wifi.mode = wifi.STATIONAP

cfg.wifi.ap={}
cfg.wifi.ap.rf={}
cfg.wifi.ap.rf.ssid="IntelliDust-" .. wifi.ap.getmac():gsub(":",""):upper()
cfg.wifi.ap.rf.pwd="12345678"

cfg.wifi.ap.net={}
cfg.wifi.ap.net.ip="192.168.111.1"
cfg.wifi.ap.net.netmask="255.255.255.0"
cfg.wifi.ap.net.gw="192.168.111.1"

cfg.wifi.sta={}
cfg.wifi.sta.mode=0
-- 0=fixed one 
-- 1=fixed client
-- 2=one of X (best signal of free wifi)
cfg.wifi.sta.ssid="STARA_KRCMA"
cfg.wifi.sta.pwd="sandeman"

