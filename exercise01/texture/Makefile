CC = clang++
CFLAGS = -Wall
LDFLAGS = -framework OpenGL -framework GLUT
BIN = texture
OBJ = texture.o bmp.o

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

clean:
	rm -f $(OBJ) $(BIN)
