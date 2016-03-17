-- should we create a separate type of object for a folder?

local icon_mt = {}

icon_mt.__tostring = function(i)
   local result = ''
   if not i.icons then -- app
      result = i.name
   else -- folder
      result = string.format('<%s>', i.name)
   end
   return result
end

local icon = {}

icon.__meta = icon_mt

return icon



-- extend type to handle these new "classes"
-- add dump function to src

-- add a fetch icon to the icon object -- but that needs the connection object .... can we create the function
-- with the conn as an upvalue ???

-- get dock and page #


-- have a flow (or fill) function that pours a list into pages ... have a percent fill parameter so that pages/folders are filled
-- to that percentage...
