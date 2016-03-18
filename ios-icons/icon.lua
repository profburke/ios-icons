local format = string.format
local icon_mt = {}


icon_mt.__tostring = function(i)
   return i.name
end


local icon = {}
icon.__meta = icon_mt


local oldtype = type
function type(v)
   if getmetatable(v) == icon_mt then
      return 'icon'
   else
      return oldtype(v)
   end
end


return icon
