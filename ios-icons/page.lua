local page_mt = {}
page_mt.__tostring = function(p)
   local result = "{\n"
   for _, i in ipairs(p) do
      result = result .. "\t" .. tostring(i) .. "\n"
   end

   result = result .. "}"
   return result
end

local page = {}

page.role = "page"
page.__meta = page_mt

return page

