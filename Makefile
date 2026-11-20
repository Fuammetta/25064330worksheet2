AS      = nasm
ASFLAGS = -f elf32
LDFLAGS = -T link.ld -melf_i386 -z noexecstack
 
all: os.iso
 
loader.o: loader.asm
	$(AS) $(ASFLAGS) loader.asm -o loader.o
 
kernel.elf: loader.o link.ld
	ld $(LDFLAGS) loader.o -o kernel.elf
 
os.iso: kernel.elf iso/boot/grub/menu.lst
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R -b boot/grub/stage2_eltorito \
        -no-emul-boot -boot-load-size 4 -A os \
        -input-charset utf8 -quiet -boot-info-table \
        -o os.iso iso
 
run: os.iso
	qemu-system-i386 -display curses -monitor telnet::49152,server,nowait \
        -serial mon:stdio -boot d -cdrom os.iso -m 32 -d cpu -D logQ.txt
 
clean:
	rm -f *.o kernel.elf os.iso iso/boot/kernel.elf logQ.txt
 
.PHONY: all run clean
