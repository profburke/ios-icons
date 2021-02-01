local stack_mt = {}

stack_mt.__tostring = function(w)
   return "<stack: tbd>"
end

local stack = {}
stack.__meta = stack_mt

local oldtype = type
function type(v)
   if getmetatable(v) == stack_mt then
      return 'stack'
   else
      return oldtype(v)
   end
end

return stack
