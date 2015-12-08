hp()
print(cfg.s.sv..": Core ST")

function hx2c(x)
  return string.char(tonumber(x, 16))
end
function u_d(i)
  return i:gsub("%+", " "):gsub("%%(%x%x)", hx2c)
end
function p_A(args)
   local r = {}; i=1
   if args == nil or args == "" then return r end
   for arg in string.gmatch(args, "([^&]+)") do
      local name, value = string.match(arg, "(.*)=(.*)")
      if name ~= nil then r[name] = u_d(value) end
      i = i + 1
   end
   return r
end
function parseFormData(body)
  local data = {}
  for kv in body.gmatch(body, "%s*&?([^=]+=[^&]+)") do
    local key, value = string.match(kv, "(.*)=(.*)")
    data[key] = u_d(value)
  end
  return data
end


print(cfg.s.sv..": Core DN")
hp()
