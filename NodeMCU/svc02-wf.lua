hp()
print(cfg.s.sv..": WiFi ST")

wifi_start_ap = nil
function wifi_start_ap()
  print("AP")
  log_debug('AP MAC: '..wifi.ap.getmac())
  wifi.ap.config(cfg.wifi.a.r)
  wifi.ap.setip(cfg.wifi.a.n)
  log_debug('AP SSID: '..cfg.wifi.a.r.ssid)
  log_debug('AP PASS: '..cfg.wifi.a.r.pwd)
end

wifi_start_sta = nil
function wifi_start_sta()
  print("Station")
  if cfg.wifi.s.m==0 then
    log_debug('STA MAC: '..wifi.sta.getmac())
    wifi.sta.config(cfg.wifi.s.s, cfg.wifi.s.p)
    wifi.sta.connect()
  elseif cfg.wifi.s.m==1 then
     print("E:STA mode "..cfg.wifi.s.m.." NOT IMPLEMENTED YET")
  elseif cfg.wifi.s.m==2 then
     print("E:STA mode "..cfg.wifi.s.m.." NOT IMPLEMENTED YET")
  else 
     print("E:unknown STA mode "..cfg.wifi.s.m)
  end
end

print("Mode:"..cfg.wifi.m)
wifi.setmode(cfg.wifi.m)

if (cfg.wifi.m == wifi.SOFTAP) or (cfg.wifi.m == wifi.STATIONAP) then
  wifi_start_ap()
end

if (cfg.wifi.m == wifi.STATION) or (cfg.wifi.m == wifi.STATIONAP) then
  wifi_start_sta()
end

wifi_start_sta = nil
wifi_start_ap = nil
cfg.wifi = nil

print(cfg.s.sv..": WiFi DN")

