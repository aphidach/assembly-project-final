yasm -f elf64 -g dwarf2 -o main.o main.s
yasm -f elf64 -g dwarf2 -o printNumber.o printNumber.s
ld -o div_new main.o printNumber.o
./div_new