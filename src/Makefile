#
# Makefile
#

SRCS = comms.c icons.c util.c ios_iconlib.c sb_ios2lua.c sb_lua2ios.c sb_registry.c save_load.c
OBJS = comms.o icons.o util.o ios_iconlib.o sb_ios2lua.o sb_lua2ios.o sb_registry.o save_load.o
LFLAGS = -bundle -undefined dynamic_lookup -all_load
CFLAGS = -O2 -fPIC
LIBS = -limobiledevice -lplist

CC = /usr/bin/llvm-gcc
CP = /bin/cp
RM = /bin/rm


iosicons: $(OBJS)
	$(CC) $(LFLAGS) -o iconlib.so $(OBJS) $(LIBS)
	$(CP) iconlib.so ../ios-icons

.c.o:
	$(CC) $(CFLAGS) -c $<

.PHONY: clean
clean:
	-$(RM) -f *.o iconlib.so
