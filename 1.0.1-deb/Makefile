IDIR =.
CC=gcc
CFLAGS=-fPIC -g -Wall -Wextra -I$(IDIR)
LDFLAGS=-shared

LIBS=-lcrypto

DEPS = rand.h rand_lcl.h

OBJ = md_rand.o rand_unix.o rand_lib.o


%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

libopensslprng.so: $(OBJ)
	gcc -o $@ $^ $(LDFLAGS) $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f *.so *.o *~ 
