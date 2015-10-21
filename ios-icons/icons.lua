
local icons = {}


icons.flatten = function(tab)
   local insert = table.insert
   local result = {}
   
   local function isEntry(e)
      return (type(e) == 'table' and e.id)
   end
   
   local function flatten(tab)
      for _,v in ipairs(tab) do
         if isEntry(v) then
            insert(result, v)
         else
            flatten(v)
         end
      end
   end

   flatten(tab)
   return result
end




icons.dock = function(tab)
   return tab[1]
end




icons.find_all = function(tab, pat)
   local strfind = string.find
   local insert = table.insert
   local result = {}
   local all_icons = tab:flatten()

   for _,v in pairs(all_icons) do
      if strfind(v.name or '', pat) then
         insert(result, v)
      end
   end
   
   return result
end




icons.find = function(tab, pat)
   local strfind = string.find
   local all_icons = tab:flatten()

   for _,v in pairs(all_icons) do
      if strfind(v.name or '', pat) then
         return v
      end
   end
   
   return nil
end




icons.find_id = function(tab, pat)
   local strfind = string.find
   local all_icons = tab:flatten()

   for _,v in pairs(all_icons) do
      if strfind(v.id or '', pat) then
         return v
      end
   end

   return nil
end




-- TODO: visit function

return icons


