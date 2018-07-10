#
VPATH = ./priv

ifeq ($(BOOSTINCLUDE),)
BOOSTINCLUDE := /usr/local/include
endif
ifeq ($(BOOSTLIB),)
ifneq ($(LD_LIBRARY_PATH),)
BOOSTLIB := $(dir $(foreach dir,$(subst :, ,$(LD_LIBRARY_PATH)),$(wildcard $(dir)/libboost_math_c99.a)))
else
BOOSTLIB := /usr/local/lib
endif
endif

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS = -I$(ERLANG_PATH) -I$(BOOSTINCLUDE) -fPIC -g -O3 -flto -mtune=generic -Wno-write-strings
LDFLAGS = -shared -L$(BOOSTLIB) $(BOOSTLIB)/libboost_math_c99.a $(BOOSTLIB)/libboost_random.a

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LDFLAGS += -undefined dynamic_lookup
endif

CC = g++

SRCS = boostnif.c
OBJS = $(SRCS:.c=.o)

priv/libboostnif.so: $(OBJS)
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

.PHONY: clean

clean:
	rm -f priv/libboostnif.so
