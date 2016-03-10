local icons_mt = {}
icons_mt.__tostring = function(i)
   local result = "Icon Set\n\n"
   for _, p in ipairs(i) do
      result = result .. tostring(p)
   end

   result = result .. "\n"
   return result
end


local icons = {}
icons.__meta = icons_mt



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




icons.visit = function(tab, visitor)
   assert(type(visitor) == 'function', 'visitor must be a function')
   for _,v in pairs(tab) do
      visitor(v)
   end
end


local dockMax = 4
local pageMax = 9
-- TODO: handle fillPercent
-- TODO: pass in page size as a parameter with a default (x = x or default)
icons.reshape = function(tab, fillPercent)
   local result = {}
   local page = {}
   local count = 1
   local insert = table.insert
   
   for i,v in ipairs(tab) do
      if i < dockMax then
         insert(page, v)
      elseif i == dockMax then
         insert(page, v)
         insert(result, page)
         page = {}
         count = 1
      elseif count % pageMax ~= 0 then
         insert(page, v)
         count = count + 1
      else
         insert(page, v)
         insert(result, page)
         page = {}
         count = 1
      end
   end
   
   return result
end


return icons


