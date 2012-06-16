CC = clang++
CFLAGS = -Wall -I/Users/andybreuhan/.homebrew/include
LDFLAGS = -framework OpenGL -framework GLUT -lglew -L/Users/andybreuhan/.homebrew/lib
BIN = $(shell basename `pwd`)
OBJ = $(patsubst %.cpp, %.o, $(wildcard *.cpp))

all: $(BIN)
	./$(BIN)

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm $(OBJ) $(BIN)
