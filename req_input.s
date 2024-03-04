section .data
    STDOUT	equ	1
    STDIN   equ 0
    STDERR 	equ	2	
    SYS_write equ 1
    SYS_read equ 0
    NOTINPUT equ -1

    number_convert_int dq 0

    inNum_one dq 0
    inNum_two dq 1
    
    start_msg db "==== start!!! ===="
    len_msg_start equ ($-start_msg)

    num_one_msg db "Enter Number 1: "
    len_num_one_msg equ ($-num_one_msg)

    num_two_msg db "Enter Number 2: "
    len_num_two_msg equ ($-num_two_msg)

    output_msg db "Output : "
    len_output_msg equ ($-output_msg)

    error_input_msg db "Error get Input"
    len_error_input_msg equ ($-error_input_msg)

    newline db 10

    input_buffer resd 0

section .text
;
;
;

global req_input
req_input:

global print_start_msg
print_start_msg:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, start_msg
    mov rdx, len_msg_start
    syscall

    call print_newLine

    ret

print_output_msg:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, output_msg
    mov rdx, len_output_msg
    syscall

    ret

global get_numOne
get_numOne:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, num_one_msg
    mov rdx, len_num_one_msg
    syscall

    call read_input

    call str_to_int
    mov qword[inNum_one], rax

    ret

global get_numTwo
get_numTwo:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, num_two_msg
    mov rdx, len_num_two_msg
    syscall

    call read_input
    
    call str_to_int
    mov qword[inNum_two], rax

    ret


read_input:
    mov rax, SYS_read
    mov rdi, STDIN
    mov rsi, input_buffer
    mov rdx, 11
    syscall

    cmp rax, NOTINPUT
    je error_input

    ret

str_to_int:
    xor rax, rax ;clear register
    xor rcx, rcx ;clear register

int_number_convert:

    movzx rdx, byte[input_buffer + rcx] 
    cmp rdx, 10 ; check if it's '\n' 
    je done_convert

    sub rdx, '0'
    imul rax,10
    add rax,rdx

    inc rcx
    jmp int_number_convert

done_convert:
    ret


print_newLine:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, newline
    mov rdx, 1
    syscall

    ret

error_input:

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, error_input
    mov rdx, len_error_input_msg
    syscall

    call exit_program

global exit_program
exit_program:
    mov rax, 60
    mov rdi, 0
    syscall