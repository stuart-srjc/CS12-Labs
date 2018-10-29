macro: macro.o ../cs12Lib/cs12Lib.o
	ld -g -o macro macro.o ../cs12Lib/cs12Lib.o

macro.o: macro.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 macro.asm -l macro.lst

clean: 
	rm -f macro
	rm -f macro.o 
	rm -f macro.lst 

