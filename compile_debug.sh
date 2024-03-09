echo yasm req_input
yasm -f elf64 -g dwarf2 -o ./dotOfile/req_input.o req_input.s

echo yasm printNumber
yasm -f elf64 -g dwarf2 -o ./dotOfile/printNumber.o printNumber.s

echo yasm main
yasm -f elf64 -g dwarf2 -o ./dotOfile/main.o main.s

echo linkfile
ld -o div_new ./dotOfile/main.o ./dotOfile/printNumber.o ./dotOfile/req_input.o

echo "---------------- run file ----------------"
echo "---------------- VVVVVVVV ----------------"
./div_new