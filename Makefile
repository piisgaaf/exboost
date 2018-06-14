#
VPATH = ./priv

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS = -I$(ERLANG_PATH) -Ideps/boost -fPIC -g -O3 -flto -mtune=generic -Wno-write-strings
LDFLAGS = -shared -undefined dynamic_lookup -Ldeps/boost/stage/lib/ -lboost_math_c99

CC = g++

SRCS = boostnif.c
OBJS = $(SRCS:.c=.o)

priv/libboostnif.so: $(OBJS)
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

.PHONY: clean

clean:
	rm -f priv/libboostnif.so
