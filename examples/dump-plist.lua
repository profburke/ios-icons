#!/usr/bin/env lua

if #arg ~= 1 then
   print "usage: dump-plist <filepath>"
   os.exit()
end

ios = require 'ios-icons'
conn = ios.connect()
icons = conn:icons()

icons:save_plist(arg[1])
