CC?=gcc
OPT=-O0 -g3 
EXTRA_CFLAGS+=-Wformat -Wformat-security -Werror=format-security
EXTRA_CFLAGS+=-D_FORTIFY_SOURCE=2
EXTRA_CFLAGS+=-fstack-protector-strong
EXTRA_CFLAGS+=-fPIE
EXTRA_CFLAGS+=-fPIC
EXTRA_CFLAGS+=-fcf-protection=full
EXTRA_CFLAGS+=-fstack-clash-protection
EXTRA_CFLAGS+=-Wall
EXTRA_CFLAGS+=-fno-strict-overflow -fno-delete-null-pointer-checks -fwrapv
EXTRA_LDFLAGS+=-pie -z noexecstack -z relro -z now

CFLAGS=$(OPT) -Wextra -Wno-parentheses $(EXTRA_CFLAGS)
LDLIBS=-pthread
LDFLAGS+=$(EXTRA_LDFLAGS)
INCFLAGS=

vpath %.h include
vpath %.c src
vpath %.o obj

all: mem-ops

OBJS_MEMDIRTY=mem-ops.o


mem-ops.o: main.c main.h
	$(CC) $(CFLAGS) $(INCFLAGS) -I include $@ 

mem-ops: $(OBJS_MEMDIRTY)
	$(CC) $(LDFLAGS) $(OBJS_MEMDIRTY) $(LDLIBS) -o $@

clean:
	$(RM) mem-ops
	$(RM) `find . -name "*.[oa]" -o -name "\#*\#" -o -name TAGS -o -name core -o -name "*.orig"`