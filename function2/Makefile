function2: function2.o ../cs12Lib/cs12Lib.o functionLib.o 
	ld -g -o function2 function2.o ../cs12Lib/cs12Lib.o functionLib.o 

function2.o: function2.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 function2.asm -l function2.lst

functionLib.o: functionLib.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 functionLib.asm -l functionLib.lst

testC: testC.o functionLib.o ../cs12Lib/cs12Lib.o 
	 gcc -no-pie -g -o testC testC.o ../cs12Lib/cs12Lib.o functionLib.o 

clean: 
	rm -f function2
	rm -f function2.o 
	rm -f function2.lst
	rm -f functionLib.o 
	rm -f functionLib.lst
	rm -f testC
	rm -f testC.o

