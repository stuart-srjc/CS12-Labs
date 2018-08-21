move: move.o
	ld -g -o move move.o

move.o: move.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 move.asm -l move.lst

clean: 
	rm -f move
	rm -f move.o 
	rm -f move.lst 

