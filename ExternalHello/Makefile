include $(APPDIR)/Make.defs

ifeq ($(CONFIG_EXTERNAL_APPS_HELLO_APP),y)

PROGNAME = $(CONFIG_EXTERNAL_APPS_HELLO_APP_PROGNAME)
PRIORITY = $(CONFIG_EXTERNAL_APPS_HELLO_APP_PRIORITY)
STACKSIZE = $(CONFIG_EXTERNAL_APPS_HELLO_APP_STACKSIZE)

MAINSRC = src/external_hello.c

# This is how to add the include directory to the build system.
# the path to the directory should match AFTER the symlink. So here it's apps/external/ExternalHello/include
CFLAGS += ${shell $(INCDIR) "$(CC)" "$(APPDIR)$(DELIM)external$(DELIM)ExternalHello$(DELIM)include"}

endif

include $(APPDIR)/Application.mk