#
PRIV_DIR ?= priv
ifneq ($(MIX_APP_PATH),)
PRIV_DIR := $(MIX_APP_PATH)/priv
endif

NIF = $(PRIV_DIR)/libboostnif.so

ifeq ($(BOOSTINCLUDE),)
BOOSTINCLUDE := /usr/local/include
endif
ifeq ($(BOOSTLIB),)
ifneq ($(LD_LIBRARY_PATH),)
BOOSTLIB := $(dir $(foreach dir,$(subst :, ,$(LD_LIBRARY_PATH)),$(wildcard $(dir)/libboost_math_c99$(BOOSTMT).a)))
else
BOOSTLIB := /usr/local/lib
endif
endif
ifeq ($(BOOSTCC),)
CC := c++
else
CC := $(BOOSTCC)
endif

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS = -I$(ERLANG_PATH) -I$(BOOSTINCLUDE) -fPIC -g -O3 -flto -mtune=generic -Wno-write-strings
LDFLAGS = -shared $(BOOSTLIB)/libboost_math_c99$(BOOSTMT).a $(BOOSTLIB)/libboost_random$(BOOSTMT).a

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LDFLAGS += -undefined dynamic_lookup
endif

SRCS = priv/boostnif.c
OBJS = $(SRCS:.c=.o)

$(NIF): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

.PHONY: clean

clean:
	rm -f priv/*.o $(NIF)
