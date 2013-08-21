#IDIR =../1.0.1-deb
IDIR =../1.0.1e
CC=gcc
CFLAGS=-I$(IDIR)

#LIBS=-L../1.0.1-deb -lopensslprng -lcrypto
LIBS=-L../1.0.1e -lopensslprng -lcrypto

DEPS=rand.h

OBJ=recycle_pid.o


%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

recycle_pid: $(OBJ)
	gcc -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f *.o *~ recycle_pid
