local insert = table.insert
local fn = {}


local append = function(a, b)
   for _, v in ipairs(b) do
      insert(a, v)
   end
end


fn.select = function(tab, cond)
   assert(type(cond) == 'function', 'cond must be a predicate')
   local t = tab
   local result = {}

   if type(t) == 'folder' then
      t = t.icons
   end
   
   for _,v in pairs(t) do
      local vt = type(v)
      if vt == 'folder' then
         local fresult = fn.select(v.icons, cond)
         append(result, fresult)
      elseif vt == 'page' then
         local fresult = fn.select(v, cond)
         append(result, fresult)
      elseif vt == 'icon' then
         if cond(v) then
            insert(result, v)
         end
      end
   end

   return result
end



return fn

