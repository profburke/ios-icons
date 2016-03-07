local icon_mt = {}
icon_mt.__tostring = function(i)
   local result = '<' .. i.name
   result = result .. ', ' .. tostring(i.id)
   result = result .. ', ' .. tostring(i.bundleIdentifier) .. '>'
   return result
end

local icon = {}

icon.role = "icon"
icon.__meta = icon_mt



return icon

