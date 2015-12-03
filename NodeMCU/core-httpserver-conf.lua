-- httpserver-conf.lua
-- Part of nodemcu-httpserver, contains static configuration for httpserver.
-- Author: Sam Dieck
-- Changes for IntelliDust: Slavoj SANTA Hruska

local conf = {}

-- Basic Authentication Conf
local auth = {}

auth.enabled = cfg.http.auth.enabled
auth.realm = cfg.http.auth.realm
auth.user = cfg.http.auth.user
auth.password = cfg.http.auth.password
conf.auth = auth

return conf
