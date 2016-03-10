ios = require "lib/ios-icons"
conn = ios.connect()
icons = conn:icons()
dock = icons:dock()

print(icons)

-- function swap(a,b)
-- 	icons:swap(a,b)
-- 	conn:set_icons(icons)
-- end


function dump(o)
	for k,v in pairs(o) do
		print(k,v)
	end
end

