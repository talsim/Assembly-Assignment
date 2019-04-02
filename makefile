all:
	nasm -f elf myasm.s -o myelf.o
	gcc -m32 main.c myelf.o -o run 

.PHONY: clean run debug
clean:
	rm -f *.o run
run:
	./run
debug:
	nasm -g -f elf myasm.s -o myelf.o
	gcc -m32 main.c myelf.o -o run
