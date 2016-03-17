
## Main Methods

### connect

Takes optional UDID and opens a connection to the specified (or default) device. Returns a connection object.


### ios_errno

idevice_errno is a global error; this prints it.


### load_plist

Reads a PLIST of an icon "structure" stored in an XML file. Returns it as a Lua table.


## Types

### connection

#### disconnect

Ends the connection to the device.

#### icons

Retrieves a Lua table describing the icons and their arrangement.


#### get_icons

Same as `icons`.


#### set_icons

Updates the device so its icon arrangement matches the passed in table.


#### icon_image

Retrives the PNG of the given app's icon. Takes an icon table as paramter.

#### _tostring

Prints the devices name or disconnected if no device.
