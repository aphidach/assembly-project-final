echo yasm req_input
yasm -f elf64 -g dwarf2 -o req_input.o req_input.s

echo yasm printNumber
yasm -f elf64 -g dwarf2 -o printNumber.o printNumber.s

echo yasm zero_precheck
yasm -f elf64 -o zero_precheck.o zero_precheck.s

echo yasm main
yasm -f elf64 -g dwarf2 -o main.o main.s

echo linkfile
ld -o div_new main.o printNumber.o req_input.o zero_precheck.o

echo "---------------- run file ----------------"
echo "---------------- VVVVVVVV ----------------"
./div_new