#!/usr/bin/env lua

status, ios = pcall(require, 'ios-icons')
if (not status) then
   print "Could not find the 'ios-icons' library."
   print "Check to verify it was installed."
   os.exit(1)
end

status, conn = pcall(ios.connect)
if (not status) then
   print "Could not detect a connected iOS device."
   os.exit(1)
end

icons = conn:icons()
icons:save_plist 'springboard.plist'
