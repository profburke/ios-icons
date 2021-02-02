local format = string.format


local page_mt = {}
page_mt.__tostring = function(p)
   local result = "{\n"
   local count = 0
   for _, i in ipairs(p) do
      result = result .. "  " .. tostring(i) .. "\n"
      count = count + 1
      if count % 4 == 0 then
         result = result .. "\n"
         count = 0
      end
   end

   result = result .. "}\n"
   return result
end


local page = {}
page.__meta = page_mt


local oldtype = type
function type(v)
   if getmetatable(v) == page_mt then
      return 'page'
   else
      return oldtype(v)
   end
end


return page

