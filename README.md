# Assembly-project-final

This assembly code is a simple calculator program written in x86_64 assembly language for Linux. It takes two integer inputs from the user and performs integer division, displaying both the quotient and remainder.

## Features

- Prompts the user to enter two integer numbers.
- Performs the division operation and displays the quotient and remainder with four decimal places.
- Handles potential errors like division by zero and invalid input.

## Requirements

1. **Linux Operating System:** This code is specifically designed for 64-bit Linux systems.
2. **Assembler (YASM):** You need YASM (Yet Another Assembler) to assemble the code. (install `sudo apt install yasm` or `sudo pacman -S yasm` )
3. **Linker (LD):** The LD (GNU Linker) is required to link the assembled code.(install `sudo apt install gcc` or `sudo pacman -S gcc` )

## Instructions
**In easy way**
1. 1 Compile the assembly code using an appropriate assembler by using script.And it will run program auto for the first time.

```bash
$ sh compile_run.sh 
```

1. 2 If compile finish you can only run file by run without compile. 

```bash
$ ./div_new
```
2. Enter the two integer numbers when prompted.

```bash
==== start!!! ====
Enter Number 1: <number>
Enter Number 2: <number>
```

**Optional**
1. Compile the assembly code using an appropriate assembler.
* It's include debug mode

```bash
$ yasm -f elf64 -g dwarf2 -o ./dotOfile/req_input.o req_input.s

$ yasm -f elf64 -g dwarf2 -o ./dotOfile/printNumber.o printNumber.s

$ yasm -f elf64 -g dwarf2 -o ./dotOfile/main.o main.s

$ ld -o div_new ./dotOfile/main.o ./dotOfile/printNumber.o ./dotOfile/req_input.o
```

2. Run the compiled executable.

 ```bash
  $ ./div_new
 ```

3. Enter the two integer numbers when prompted.

```bash
==== start!!! ====
Enter Number 1: <number>
Enter Number 2: <number>
```

4. The program will display the result of the division with four decimal places.

### Example

```bash
==== start!!! ====
Enter Number 1: 12345
Enter Number 2: 5
Output : 2469.0000
```

## Code Structure

- The code is divided into sections:
  - `.data`: Stores constant strings and data.
  - `.text`: Contains the main program logic and functions.
- The program starts at the `_start` function.
- Subroutines:
  - `_start`: The program entry point.
  - `print_start_msg`: Prints the start message.
  - `get_numOne` and `get_numTwo`: Prompt the user for input and convert the input string to an integer.
  - `div_result`: Performs the division operation and calculates the remainder with four decimal places.
  - `showresult`: Prints the quotient and remainder with formatting.
  - `printNumber`: Converts an integer to ASCII string and prints it character by character.
  - `print_character`: Prints a single character.
  - `print_output_msg`: Prints the "Output :" message.
  - `read_input`: Reads input from the standard input (keyboard).
  - `str_to_int`: Converts a string containing digits to an integer.
  - `print_newLine`: Prints a newline character.
  - `error_input`: Handles invalid input and prints an error message.
  - `exit_program`: Exits the program.

## Contributing

Feel free to contribute to this project by suggesting improvements or reporting issues.
