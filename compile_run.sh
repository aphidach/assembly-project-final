echo do yasm req_input
yasm -f elf64 -o ./dotOfile/req_input.o req_input.s

echo do yasm printNumber
yasm -f elf64 -o ./dotOfile/printNumber.o printNumber.s

echo do yasm main
yasm -f elf64 -o ./dotOfile/main.o main.s

echo do linkfile
ld -o div_new ./dotOfile/main.o ./dotOfile/printNumber.o ./dotOfile/req_input.o

echo "---------------- run file ----------------"
echo "---------------- VVVVVVVV ----------------"
./div_new