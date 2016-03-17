local format = string.format


local page_mt = {}
page_mt.__tostring = function(p)
   local result = "{\n\t"
   local count = 0
   for _, i in ipairs(p) do
      result = result .. format('%-20s ', tostring(i))
      count = count + 1
      if count % 4 == 0 then
         result = result .. "\n\t"
         count = 0
      end
   end

   result = result .. "\n}\n"
   return result
end


local page = {}
page.__meta = page_mt
return page

