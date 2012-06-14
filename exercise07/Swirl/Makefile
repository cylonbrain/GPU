DYLD_LIBRARY_PATH=/usr/local/cuda/lib
PATH=/usr/local/cuda/bin:$PATH
CC = /usr/local/cuda/bin/nvcc 
CFLAGS =  
LDFLAGS = 
BIN = $(shell basename `pwd`)
OBJ = $(patsubst %.cu, %.o, $(wildcard *.cu))

all: $(BIN)
	./$(BIN)

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.o: %.cu
	$(CC) $(CFLAGS) -c $<

clean:
	rm $(OBJ) $(BIN)
