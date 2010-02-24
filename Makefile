EXEC=bin/aped
LIBRARY=lib/libaped.so

prefix		= /usr/local
bindir		= $(prefix)/bin
libdir		= $(prefix)/lib

LIBAPED_SRC	= src/sock.c src/hash.c src/handle_http.c src/cmd.c src/users.c src/channel.c src/config.c src/json.c \
		  src/json_parser.c src/plugins.c src/http.c src/extend.c src/utils.c src/ticks.c src/base64.c src/pipe.c \
		  src/raw.c src/events.c src/event_kqueue.c src/event_epoll.c src/transports.c src/servers.c src/dns.c \
		  src/sha1.c src/log.c src/parser.c
APED_SRC	= src/entry.c

CFLAGS 		+= -Wall -O2 -minline-all-stringops $(EXTRA_CFLAGS)
CPPFLAGS 	+= -I ./deps/udns-0.0.9/ -D_GNU_SOURCE
LDFLAGS		+= -ldl -lm -lpthread -Wl,-rpath=$(libdir) -L$(dir $(LIBRARY)) $(EXTRA_LDFLAGS) -Wl,-rpath=$(abspath $(dir $(LIBRARY)))
CC		= gcc
LD		= $(CC) -shared
RM		= rm -f

all: $(LIBRARY) $(EXEC)
	
$(EXEC): LOADLIBES += -laped
$(EXEC): $(APED_SRC:.c=.o)
	@[ -d $(dir $@) ] || mkdir -p $(dir $@) || echo "*** error: could not mkdir $(dir $@)"
	$(CC) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(LIBRARY): $(LIBAPED_SRC:.c=.o) ./deps/udns-0.0.9/libudns.a
	@[ -d $(dir $@) ] || mkdir -p $(dir $@) || echo "*** error: could not mkdir $(dir $@)"
	$(LD) $(LDFLAGS) $^ -o $@

$(LIBAPED_SRC:.c=.o):	EXTRA_CFLAGS += -fPIC

install: 
	install -d $(bindir)
	install -m 755 $(EXEC) $(bindir)
	install	-m 755 $(LIBRARY) $(libdir)

uninstall:
	$(RM) $(bindir)/$(notdir $(EXEC))
	$(RM) $(libdir)/$(notdir $(LIBRARY))

clean:
	$(RM) $(EXEC) $(LIBRARY)
