#ifndef ICONS_H
#define ICONS_H

struct lua_State;

static char *const kGetImageDataName = "imagedata";
static char *const kSavePlistMethodName = "save_plist";

int ios_get_icons(lua_State *L);
int ios_set_icons(lua_State *L);
int ios_icon_imagedata(lua_State* L);
int ios_wallpaper(lua_State* L);

#endif
