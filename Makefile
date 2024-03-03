mainf:
	yasm -f elf64 -g dwarf2 -o main.o main.asm
	ld -o main main.o
	gdb ./main
convertf:
	yasm -f elf64 -g dwarf2 -o convert.o convert.s
	ld -o convert convert.o
	gdb ./convert
divf:
	yasm -f elf64 -g dwarf2 -o div_with4rem.o div_with4rem.s
	ld -o div_with4rem div_with4rem.o
	gdb ./div_with4rem

testf:
	yasm -f elf64 -g dwarf2 -o test.o test.s
	ld -o test test.o
	gdb ./test

linktest:
	yasm -f elf64 -g dwarf2 -o div_4.o div_4.s
	yasm -f elf64 -g dwarf2 -o printNumber.o printNumber.s
	ld -o div_new div_4.o printNumber.o
	gdb ./div_new