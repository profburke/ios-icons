#include <stdio.h>
#include <string.h>
#include <lua.h>

#include <plist/plist.h>

#include "ios-icons.h"
#include "icons.h"
#include "springboard.h"
#include "util.h"
#include "sb_ios2lua.h"

// Converts the passed in plist and converts it to a Lua table.
// The entry at index 1 is the dock icons, so page 1 is at index 2
// and so on.
int ios_plist_to_table(lua_State* L, plist_t iconState) {
  lua_newtable(L);
  parseNode(L, iconState, 0);
  lua_rawgeti(L, -1, 1);
  lua_remove(L, -2);
  return 1;
}

void parseNode(lua_State* L, plist_t node, int depth) {
  char* name, *id, *bundleId, *iconType;
  plist_t kids, elements;
  int numChildren;
  int i;
  
  if (node == NULL) { return; }

  switch (nodeType(node)) {
  case PLIST_DICT:
    lua_newtable(L);
    
    iconType = getStringVal(node, kAppleIconTypeKey);
    id = getStringVal(node, kAppleDisplayIDKey);
    name = getStringVal(node, kAppleDisplayNameKey);
    bundleId = getStringVal(node, kAppleBundleIdKey);
    kids = dictEntry(node, kAppleIconListKey);
    elements = dictEntry(node, kAppleElementsKey);
    
    if (iconType != NULL && strcmp(iconType, "custom") == 0) {
      // Item is either a widget or a smart stack.
      addToTable(L, groupSize(elements) > 0 ? kSmartStackTypeKey : kWidgetTypeKey);
    } else {
      // Item is an app or a folder.
      addToTable(L, groupSize(kids) > 0 ? kFolderTypeKey : kIconUserDataType);
    }

    if (name == NULL && id == NULL) {
      lua_pushstring(L, "unexpected value reading icons!");
      lua_error(L);
    }
    
    if (name != NULL) { SET_STRING(L, kIconName,name); }
    if (id != NULL) { SET_STRING(L, kIconId,id); }
    if (bundleId != NULL) { SET_STRING(L, kAppleBundleIdKey,id); }
    storeIconInRegistry(L, node, name, id); 

    // TODO: remove the duplication
    
    // If item is a folder, add the contained apps as a table.
    if (groupSize(kids) > 0) {
      lua_newtable(L);
      flatPackArray(L, kids, depth+1);
      lua_setfield(L, -2, kIconsKey);
    }

    // TODO: "Siri Suggestions" doesn't contain a bundle ID, so
    // if a stack contains it, the following crashes...
    // If item is a stack, add the contained widgets as a table.
    // if (groupSize(elements) > 0) {
    // lua_newtable(L);
    //   flatPackArray(L, elements, depth+1);
    // lua_setfield(L, -2, kElementsKey);
    // }
break;
    
  case PLIST_ARRAY:
    lua_newtable(L);
    addToTable(L, depth == 0 ? kIconCollectionTypeKey : kPageTypeKey);
    
    numChildren = groupSize(node);
    for (i=0;i<numChildren;i++) {
      parseNode(L, arrayElem(node, i), depth+1);
    }
    
  default:
    break;
    
  case PLIST_BOOLEAN: break;
  case PLIST_UINT: break;
  case PLIST_REAL: break;
  case PLIST_STRING: break;
  case PLIST_DATE: break;
  case PLIST_DATA: break;
  case PLIST_KEY: break;
  case PLIST_UID: break;
  case PLIST_NONE: break;
  }
  
  // append to the end of our parent container
  lua_rawseti(L, -2, lua_rawlen(L, -2) + 1);
}

// unfortunately we get back all groups double wrapped, seems
// apple was preparing for something that never came, if that
// day does come this might need to go
void flatPackArray(lua_State* L, plist_t node, int depth) {
  int i;
  
  if (nodeType(node) == PLIST_ARRAY) {
    for (i=0;i<groupSize(node);i++) {
      flatPackArray(L, arrayElem(node, i), depth);
    }      
  } else {
    parseNode(L, node, depth);
  }
}

char *getStringVal(plist_t dict, const char* key) {
  char* charVal = "";
  plist_t plistItem = dictEntry(dict, key);

  switch (nodeType(plistItem)) {
  case PLIST_STRING:
    stringVal(plistItem,&charVal);
    break;
  default: // fall through to empty val.
  case PLIST_NONE:
    charVal = NULL;
    break;
  }
  
  return charVal;
}

