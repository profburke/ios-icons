local fn = {}


-- cond should be a predicate
fn.select = function(tab, cond)
   assert(type(cond) == 'function', 'cond must be a predicate function')
   local insert = table.insert
   local result = {}

   for _,v in pairs(tab) do
      if cond(v) then
         insert(result, v)
      end
   end

   return result
end



return fn

