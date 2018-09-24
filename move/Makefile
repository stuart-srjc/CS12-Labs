move: move.o ../cs12Lib/cs12Lib.o
	ld -g -o move move.o ../cs12Lib/cs12Lib.o

move.o: move.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 move.asm -l move.lst

clean: 
	rm -f move
	rm -f move.o 
	rm -f move.lst 

