local format = string.format
local folder_mt = {}

folder_mt.__tostring = function(f)
   return format('<%s>', f.name)
end


local folder = {}

folder.__meta = folder_mt

return folder

