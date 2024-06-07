CC = gcc
CFLAGS = -I/usr/include -fPIC
LDFLAGS = -shared
TARGET = server.so

all: $(TARGET)

$(TARGET): server.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(TARGET) server.c

clean:
	rm -f $(TARGET)
