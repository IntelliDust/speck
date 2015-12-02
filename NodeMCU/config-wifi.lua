cfg.wifi={}
cfg.wifi.mode = wifi.STATIONAP

cfg.wifi.ap={}
cfg.wifi.ap.ssid="IntelliDust-" .. wifi.ap.getmac():gsub(":",""):upper()
cfg.wifi.ap.pwd="12345678"

cfg.wifi.ap.net={}
cfg.wifi.ap.net.ip="192.168.111.1"
cfg.wifi.ap.net.netmask="255.255.255.0"
cfg.wifi.ap.net.gw="192.168.111.1"

cfg.wifi.sta={}
cfg.wifi.sta.ssid="Internet"
cfg.wifi.sta.pwd=""

