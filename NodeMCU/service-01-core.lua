hp()
print(cfg.s.sv..": Core ST")

function hex_to_char(x)
  return string.char(tonumber(x, 16))
end
function uri_decode(i)
  return i:gsub("%+", " "):gsub("%%(%x%x)", hex_to_char)
end
function parseArgs(args)
   local r = {}; i=1
   if args == nil or args == "" then return r end
   for arg in string.gmatch(args, "([^&]+)") do
      local name, value = string.match(arg, "(.*)=(.*)")
      if name ~= nil then r[name] = uri_decode(value) end
      i = i + 1
   end
   return r
end
function parseFormData(body)
  local data = {}
  for kv in body.gmatch(body, "%s*&?([^=]+=[^&]+)") do
    local key, value = string.match(kv, "(.*)=(.*)")
    data[key] = uri_decode(value)
  end
  return data
end


print(cfg.s.sv..": Core DN")
hp()
