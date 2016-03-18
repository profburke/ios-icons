ios = require 'ios-icons'
fn = require 'ios-icons.fn'

conn = ios.connect()
icons = conn:icons()
dock = icons:dock()

print(icons)


function dump(o)
	for k,v in pairs(o) do
		print(k,v)
	end
end

