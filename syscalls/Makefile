syscalls: syscalls.o 
	ld -g -o syscalls syscalls.o ../cs12Lib/cs12Lib.o


syscalls.o: syscalls.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 syscalls.asm -l syscalls.lst

clean: 
	rm -f syscalls
	rm -f syscalls.o 
	rm -f syscalls.lst 

