#
# The only purpose of this Makefile is make tests.
#
# libImlib2.so
#

DEBUG=0

ifeq ($(DEBUG), 1)
$(info Building with debug option)
	CFLAGS=-DDEBUG
else
	CFLAGS=-DNDEBUG
endif

CC = cc

all: Imlib2.o Imlib2.so

Imlib2.o:
	$(CC) $(CFLAGS) -fPIC -o Imlib2.o -c Imlib2.c

Imlib2.so:
	$(CC) -lImlib2 -shared -s -o Imlib2.so Imlib2.o

install:
	cp Imlib2.so ../lib/Imlib2.so

clean:
	rm Imlib2.so Imlib2.o

mrproper: clean
