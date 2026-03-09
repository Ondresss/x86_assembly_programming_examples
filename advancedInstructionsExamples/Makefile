TARGET = main
ARCH = 32

C_SOURCES = $(wildcard *.c)
ASM_SOURCES = $(wildcard *.asm)

OBJ = $(C_SOURCES:.c=.o) $(ASM_SOURCES:.asm=.o)


ifeq ($(ARCH), 32)
    CFLAGS += -m32
    ASM_FORMAT = elf32
else

    ASM_FORMAT = elf64
endif

CFLAGS += $(shell gcc -v 2>&1 | grep enable-default-pie > /dev/null && echo \-no\-pie)
CFLAGS += -g -std=c99
LDFLAGS = -z noexecstack


all: $(TARGET)

%.o: %.asm
	nasm -g -f $(ASM_FORMAT) -Fdwarf $< -o $@


%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $(TARGET) $(LDFLAGS)

clean:
	rm -rf $(TARGET) *.o

.PHONY: all clean