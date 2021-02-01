local widget_mt = {}

widget_mt.__tostring = function(w)
   return "<widget: tbd>"
end

local widget = {}
widget.__meta = widget_mt

local oldtype = type
function type(v)
   if getmetatable(v) == widget_mt then
      return 'widget'
   else
      return oldtype(v)
   end
end

return widget
