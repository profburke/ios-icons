#!/usr/bin/env lua
ios = require 'lib/ios-icons'
conn = ios.connect()
icons = conn:icons()

print "Info on the left-most docked app:\n"
for k,v in pairs(icons[1][1]) do print(string.format('%18s: %s', k, v)) end


