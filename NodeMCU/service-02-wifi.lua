cfg.strings.wifi_name="WiFi service"
print("Service: "..cfg.strings.wifi_name.." "..cfg.strings.starting)

wifi_start_ap = nil
function wifi_start_ap()
  print(" Starting WiFi AP")
  log_debug('  AP '..'MAC: ',wifi.ap.getmac())
  wifi.ap.config(cfg.wifi.ap.rf)
  log_debug('  AP '..'SSID: ',cfg.wifi.ap.rf.ssid)
  log_debug('  AP '..'PASS: ',cfg.wifi.ap.rf.pwd)
  wifi.ap.setip(cfg.wifi.ap.net)
end

wifi_start_sta = nil
function wifi_start_sta()
  print(" Starting WiFi Station")
  if cfg.wifi.sta.mode==0 then
    log_debug('  STA '..'MAC: ',wifi.sta.getmac())
    wifi.sta.config(cfg.wifi.sta.ssid, cfg.wifi.sta.pwd)
    wifi.sta.connect()
  elseif cfg.wifi.sta.mode==1 then
     print(" Error: STA mode "..cfg.wifi.sta.mode.." NOT IMPLEMENTED YET")
  elseif cfg.wifi.sta.mode==2 then
     print(" Error: STA mode "..cfg.wifi.sta.mode.." NOT IMPLEMENTED YET")
  else 
     print(" Error: unknown STA mode "..cfg.wifi.sta.mode)
  end
end

print("Wifi mode configured to "..cfg.wifi.mode)
wifi.setmode(cfg.wifi.mode)

cfg.wifi.mode_ap=0;
if (cfg.wifi.mode == wifi.SOFTAP) or (cfg.wifi.mode == wifi.STATIONAP) then
  cfg.wifi.mode_ap=1;
  wifi_start_ap()
end

cfg.wifi.mode_sta=0;
if (cfg.wifi.mode == wifi.STATION) or (cfg.wifi.mode == wifi.STATIONAP) then
  cfg.wifi.mode_sta=1;
  wifi_start_sta()
end

wifi_start_sta = nil
wifi_start_ap = nil

print("Service: WiFi started")

