CXX = g++
CXXFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

all: kernel.bin





kernel.bin: kernel.o
	$(CXX) -T linker.ld -o $@ $^ -ffreestanding -O2 -nostdlib

kernel.o: kernel.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean:
	rm -f *.o *.bin