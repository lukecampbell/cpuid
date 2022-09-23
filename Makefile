CC=gcc
PYTHON_INCLUDES=$$(python3-config --includes)

all: cpuid.so

cpuid.o: cpuid.s
	$(CC) -o $@ -c $<

cpuid_python.o: cpuid_python.c
	$(CC) -c -fpic --shared $(PYTHON_INCLUDES) -g -ggdb -o $@ $<

cpuid.so: cpuid.o cpuid_python.o
	$(CC) -o $@ -fpic --shared $^

clean:
	rm -f *.o cpuid.so
