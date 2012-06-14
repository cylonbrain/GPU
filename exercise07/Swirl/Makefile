CC = /usr/local/cuda/bin/nvcc 
CFLAGS = -I$(HOME)/.homebrew/include
LDFLAGS = --linker-options "-framework,OpenGL,-framework,GLUT"
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
