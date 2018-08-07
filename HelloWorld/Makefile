helloWorld: helloWorld.o
	ld -o helloWorld helloWorld.o

helloWorld.o: helloWorld.s
	as --gstabs helloWorld.s -o helloWorld.o

clean:
	rm helloWorld
	rm helloWorld.o 
