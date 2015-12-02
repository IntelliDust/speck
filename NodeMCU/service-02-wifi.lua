print("Service: WiFi service starting")

wifi_start_ap = nil
function wifi_start_ap()
  print(" Starting WiFi AP")
  print(' AP MAC: ',wifi.ap.getmac())
  wifi.ap.config(cfg.wifi.ap.rf)
  wifi.ap.setip(cfg.wifi.ap.net)
end

wifi_start_sta = nil
function wifi_start_sta()
  print(" Starting WiFi Station")
end


print("Wifi mode configured to "..cfg.wifi.mode)
wifi.setmode(cfg.wifi.mode)

if (cfg.wifi.mode == wifi.SOFTAP) or (cfg.wifi.mode == wifi.STATIONAP) then
  wifi_start_ap()
end
if (cfg.wifi.mode == wifi.STATION) or (cfg.wifi.mode == wifi.STATIONAP) then
  wifi_start_sta()
end

wifi_start_sta = nil
wifi_start_ap = nil

print("Service: WiFi service started")

