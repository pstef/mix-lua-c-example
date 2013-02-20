RM	= rm -f
SYMLINK	= ln -s
CC	= clang
RUNTIME	= -fcatch-undefined-behavior
WARNS	= -Wall -Wextra
DEBUG	= -g3
OPT	= -O0
STDS	= -D_POSIX_C_SOURCE=200112L -std=c99 -pedantic
LIBS	= -llua -lrt
SILENCE	= -Wno-unused-parameter
C_ARGS	= $(STDS) $(WARNS) $(DEBUG) $(OPT) $(SILENCE) $(RUNTIME)
O_FILES = sleep.o
term	= \x1b[0m
green	= \x1b[32;01m
yellow	= \x1b[33;01m
white	= \x1b[37;01m
OUTPUT	= $(green)$@$(term)
SOURCE	= $(white)$<$(term)

all: driver clock.lc main.lc

driver: driver.c utils.h $(O_FILES)
	@echo -e "$(CC) -o $(OUTPUT) $(SOURCE) $(yellow)$(O_FILES)$(term)"
	@$(CC) $(C_ARGS) $(LIBS) $(O_FILES) -o $@ $<

.c.o:
	@echo -e "$(CC) -c -o $(yellow)$@$(term) $(SOURCE)"
	@$(CC) $(C_ARGS) -c -o $@ $<

.lua.lc:
	@echo -e "luac -o $(OUTPUT) $(SOURCE)"
	@luac -o $@ $<

release: driver clock.lc main.lc
	cp *.lc ../
	cp driver ../

clean:
	$(RM) driver *.lc *.o core core.* *~ *.bak *.plist

.PHONY: clean release all
.SUFFIXES: .c .o .h .lc .lua

sleep.o: sleep.c
main.lc: main.lua
clock.lc: clock.lua
