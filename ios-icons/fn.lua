local insert = table.insert
local fn = {}


local append = function(a, b)
   for _, v in ipairs(b) do
      insert(a, v)
   end
end


fn.select = function(tab, cond)
   assert(type(cond) == 'function', 'cond must be a predicate')
   local result = {}

   for _,v in pairs(tab) do
      if type(v) == 'folder' then
         local fresult = fn.select(v.icons, cond)
         append(result, fresult)
      elseif type(v) == 'page' then
         local fresult = fn.select(v, cond)
         append(result, fresult)
      elseif type(v) == 'icon' then
         if cond(v) then
            insert(result, v)
         end
      end
   end

   return result
end



return fn

