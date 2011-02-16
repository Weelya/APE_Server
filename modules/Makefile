MODULES = lib/libape-spidermonkey.so

include ../platform.mk
CFLAGS	+= $(EXTRA_CFLAGS) -Wall -O2 -fPIC -g
LDFLAGS	+= $(EXTRA_LDFLAGS) 
RM	?= rm -f

GPSEE_CONFIG	?= gpsee-config
CC		 = $(shell $(GPSEE_CONFIG) --cc)
CPPFLAGS	+= $(shell $(GPSEE_CONFIG) --cppflags)
LDFLAGS		+= $(shell $(GPSEE_CONFIG) --ldflags)

include ./mysql.mk
ifeq ($(HAS_MYSQL), yes)
CPPFLAGS	+= -I./deps/mysac/
LDFLAGS   	+= -L./deps/mysac/ 
LOADLIBES 	+= -lmysac -lmysqlclient_r
endif

ifdef DARWIN_BUILD
LD	= $(CC) -bundle -undefined suppress -flat_namespace
endif

ifdef LINUX_BUILD
LD	= $(CC) -shared
CFLAGS	+= -rdynamic
endif

ifdef SOLARIS_BUILD
LD	= $(CC) -shared
endif

all: $(MODULES)

build_debug:
	@echo LDFLAGS=$(LDFLAGS)

lib/libape-spidermonkey.so: libape-spidermonkey.o
	$(LD) $(LDFLAGS) $^ -o $@ $(LOADLIBES)

clean:
	$(RM) $(MODULES) $(notdir $(MODULES:.so=.o))
