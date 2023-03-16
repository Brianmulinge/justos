CFLAGS = -g -ffreestanding -Wall -Wextra -fno-exceptions -fno-rtti -m32
LDFLAGS = -T kernel/linker.ld -m i386pe -nostdlib

all: justos.iso

clean:
	cmd /C del /Q kernel\*.o
	cmd /C del /Q kernel.bin
	cmd /C del /Q justos.iso

kernel\main.o: kernel\main.cpp
	g++ $(CFLAGS) -c -o $@ $<

kernel.bin: kernel\main.o
	ld $(LDFLAGS) -o $@ $<

justos.iso: kernel.bin grub.cfg
	cmd /C if not exist iso\boot mkdir iso\boot
	cmd /C if not exist iso\boot\grub mkdir iso\boot\grub
	cmd /C copy /Y kernel.bin iso\boot\kernel.bin
	cmd /C copy /Y grub.cfg iso\boot\grub\grub.cfg
	grub-mkrescue -o $@ iso
