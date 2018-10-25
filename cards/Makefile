cards: cards.o ../cs12Lib/cs12Lib.o
	ld -g -o cards cards.o ../cs12Lib/cs12Lib.o

cards.o: cards.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 cards.asm -l cards.lst

driver: driver.o ../cs12Lib/cs12Lib.o
	ld -g -o driver driver.o ../cs12Lib/cs12Lib.o

driver.o: driver.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 driver.asm -l driver.lst

all:	cards driver

clean: 
	rm -f cards
	rm -f cards.o 
	rm -f cards.lst 
	rm -f driver 
	rm -f driver.o 
	rm -f driver.lst 

