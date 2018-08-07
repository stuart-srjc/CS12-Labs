example: example.o
	ld -g -o example example.o

example.o: example.asm
	yasm -g dwarf2 -f elf64 example.asm -l example.lst

clean:
	rm example -f
	rm example.o -f 
	rm example.lst -f
