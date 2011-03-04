#WITH_GPSEE_DEBUGGER=Yes
ifdef WITH_GPSEE_DEBUGGER
CPPFLAGS += -I/var/surelynx/gpsee/apr_surelynx/ "-DGPSEE_DEBUGGER=\"/var/surelynx/platform/SunOS-5.10-sun4u-sparc/lib/apr_surelynx/jsdb/debugger.js\""
endif

MODULES = lib/libape-spidermonkey.so

include ../platform.mk
CFLAGS	+= $(EXTRA_CFLAGS) -Wall -O0 -fPIC -g
LDFLAGS	+= $(EXTRA_LDFLAGS) 
RM	?= rm -f

GPSEE_CONFIG	?= gpsee-config
CC		 = $(shell $(GPSEE_CONFIG) --cc)
CPPFLAGS	+= $(shell $(GPSEE_CONFIG) --cppflags)
LDFLAGS		+= $(shell $(GPSEE_CONFIG) --ldflags)
ifdef WITH_GPSEE_DEBUGGER
LDFLAGS := $(filter-out -lgpsee,$(LDFLAGS)) -lgpsee -lgpsee-jsdb
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
