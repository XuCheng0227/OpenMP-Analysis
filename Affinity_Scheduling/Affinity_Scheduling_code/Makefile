MF=	Makefile

# C compiler and options for Intel
CC=     icc -O3 -g -qopenmp -std=c99
LIB=    -lm

# C compiler and options for GNU
#CC=     gcc -O3 -fopenmp
#LIB=	-lm


EXE=	loops2
INC= affinity.h
SRC= \
	loops2.c \
	affinity.c \

OBJ=	$(SRC:.c=.o)

.SUFFIXES:
.SUFFIXES: .c .o

# .c.o is equivalent to %.o:%.c
.c.o:
	$(CC) -c $<

all:	$(EXE)

$(EXE): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LIB)

$(OBJ):	$(INC)

$(OBJ):	$(MF)

#
# Clean out object files and the executable.
#
clean:
	rm $(EXE) $(OBJ) *slurm-*
