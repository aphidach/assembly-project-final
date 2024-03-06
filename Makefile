ass-run:
	yasm -f elf64 -o req_input.o req_input.s

# echo do yasm printNumber
	yasm -f elf64 -o printNumber.o printNumber.s

# echo do yasm main
	yasm -f elf64 -o main.o main.s

# echo do linkfile
	ld -o div_new main.o printNumber.o req_input.o

# echo "---------------- run file ----------------"
# echo "---------------- VVVVVVVV ----------------"
	./div_new