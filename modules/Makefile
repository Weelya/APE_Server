MODULES = lib/libape-spidermonkey.so

include ./plateform.mk
CC	?= gcc
CFLAGS	+= $(EXTRA_CFLAGS) -Wall -O2 -fPIC
LDFLAGS	+= $(EXTRA_LDFLAGS) 
RM	?= rm -f

ifeq ($(HAS_GPSEE), yes)
GPSEE_PREFIX 	?= /usr/local/gpsee
GPSEE_CONFIG 	?= $(GPSEE_PREFIX)/bin/gpsee-config
CPPFLAGS	+= $(shell $(GPSEE_CONFIG) --cppflags)
LDFLAGS		+= $(shell $(GPSEE_CONFIG) --ldflags)
else
LDFLAGS		+= -lstdc++
endif

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

all: $(MODULES)

build_debug:
	@echo LDFLAGS=$(LDFLAGS)

lib/libape-spidermonkey.so: libape-spidermonkey.o
	$(LD) $(LDFLAGS) $^ -o $@ $(LOADLIBES)

clean:
	$(RM) $(MODULES)
