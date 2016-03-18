local format = string.format
local folder_mt = {}


folder_mt.__tostring = function(f)
   return format('<%s>', f.name)
end


local folder = {}
folder.__meta = folder_mt


local oldtype = type
function type(v)
   if getmetatable(v) == folder_mt then
      return 'folder'
   else
      return oldtype(v)
   end
end


return folder

