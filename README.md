# [IntelliDust - Speck](https://github.com/IntelliDust/speck)
A (very) simple framerowk in Lua for the ESP8266 running the NodeMCU firmware for fast development.
Speck is an client system for implementation smart home appliance that comunicate with [IntelliDust - Broom](https://github.com/IntelliDust/broom) acting like simple aggregating server

HomePage: (http://www.intellidust.eu)

## Inspiraton - included code
* [marcoskirsch - nodemcu-httpserver](https://raw.githubusercontent.com/marcoskirsch/nodemcu-httpserver/)

## Features

* Server-side execution of Lua scripts
* HTTP Basic Authentication

## TO-DO

project just started, so there are more to do, that is done ;)


## NodeMCU LUA restrictions

* Timers 0-3 are alocated for system purposes. So if you need to use TMR.ALARM() do not use 0-3 timers. Same rule for TMR.STOP()

## Notes

ESP8266 suffering on RAM, so compiling some bigger LUA files on ESP8266 side is tricky.
For PC side compilation LUA to LC you need to download compiler from (https://code.google.com/p/luaforwindows/downloads/detail?name=LuaForWindows_v5.1.4-46.exe&can=2&q=)

## current heap status

```
NodeMCU 0.9.6 build 20150704  powered by Lua 5.1.4
Speeding CPU160MHZ
Heap=	29984
IntelliDust Speck loading
Compiling LUA files
Compiling LUA config files
 Compiling:	cfg.lua
Heap=	29776
 Compiling:	cfg-brm.lua
Heap=	29776
 Compiling:	cfg-st.lua
Heap=	29776
 Compiling:	cfg-wf.lua
Heap=	29776
Heap=	28688
IntelliDust Speck
Heap=	27712
Heap=	22760
Kernel GO
Heap=	21696
Service: CG DN(60 s.)
Heap=	20072
Service: Core ST
Service: Core DN
Heap=	19704
Heap=	17872
Service: WiFi ST
Mode:2
AP
DEBUG: 	AP MAC: 5e:cf:7f:06:f4:93
DEBUG: 	AP SSID: IntelliDust5ECF7F06F493
DEBUG: 	AP PASS: 12345678
Service: WiFi DN
Kernel DN
Heap=	16472
> =node.heap()
28832
>```