template: template.o ../cs12Lib/cs12Lib.o
	ld -g -o template template.o ../cs12Lib/cs12Lib.o

template.o: template.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 template.asm -l template.lst

clean: 
	rm -f template
	rm -f template.o 
	rm -f template.lst 

