yasm -f elf64 -g dwarf2 -o div_4.o div_4.s
yasm -f elf64 -g dwarf2 -o printNumber.o printNumber.s
ld -o div_new div_4.o printNumber.o
./div_new