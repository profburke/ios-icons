local format = string.format
local icon_mt = {}

icon_mt.__tostring = function(i)
   local result = ''
   if not i.icons then -- app
      result = i.name
   else -- folder
      result = format('<%s>', i.name)
   end
   return result
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



-- extend type to handle these new "classes"
-- add dump function to src

-- add a fetch icon to the icon object -- but that needs the connection object .... can we create the function
-- with the conn as an upvalue ???

-- get dock and page #


-- have a flow (or fill) function that pours a list into pages ... have a percent fill parameter so that pages/folders are filled
-- to that percentage...
