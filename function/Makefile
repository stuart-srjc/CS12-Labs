function: function.o ../cs12Lib/cs12Lib.o functionLib.o 
	ld -g -o function function.o ../cs12Lib/cs12Lib.o functionLib.o 

function.o: function.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 function.asm -l function.lst

functionLib.o: functionLib.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 functionLib.asm -l functionLib.lst

testC: testC.o functionLib.o ../cs12Lib/cs12Lib.o 
	 gcc -g -o testC testC.o ../cs12Lib/cs12Lib.o functionLib.o 

clean: 
	rm -f function
	rm -f function.o 
	rm -f function.lst
	rm -f functionLib.o 
	rm -f functionLib.lst
	rm -f testC
	rm -f testC.o

