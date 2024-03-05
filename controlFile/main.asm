global _start

section .data
    STDOUT	equ	1
    STDIN   equ 0
    STDERR 	equ	2	
    SYS_write equ 1
    SYS_read equ 0
    NOTINPUT equ -1

    div_ANS dq 0
    div_rem dq 0

    dot db "."
    ENDLINE db "",10
    const10 dq 10
    four_zero db "0000",10

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
_start:

    call print_start_msg

    call get_numOne

    call get_numTwo

    mov rdx, 0
    mov rax, qword[inNum_one]    ;dividend
    mov rbx, qword[inNum_two]      ;divisor
    div rbx         ;rax = quotient, rdx = remainder
    call div_result ;call subroutine to display result 

    call exit_program

div_result:
    push rax
    push rdx
    push rbx

    ;req 3 agument 
        ;rdx req remainder from div
        ;rbx for find the remainder 4 point
        ;rax req answer for show ANS
    mov qword[div_ANS], rax

    mov rax, rdx        ;for find rem by div
    imul rax, 10000     ;for calculate 4 point floting
    xor rdx, rdx        ;clear rdx for div rax only
    div rbx             ;rax = remeinder 4 digi

    mov qword[div_rem], rax
    ;Result  qword[div_ANS].qword[div_rem]

    ;1's arugment is qword[div_ANS]
    ;2's arugment is qword[div_rem]
    call showresult ;call subroutine to display result 

    pop rbx
    pop rdx
    pop rax
    ret


showresult:

    call print_output_msg
    ;console quotient
    mov rax, qword[div_ANS]
    mov rdx, 0
    call printNumber

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, dot
    mov rdx, 1
    syscall

    ;console remainder
    mov rax, qword[div_rem]
    cmp rax, 0              ;if remainder == 0 jump to console "0000"
    je .case_zero
    mov rdx, 0
    call printNumber   

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, ENDLINE
    mov rdx, 1
    syscall 
    ret
.case_zero
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, four_zero
    mov rdx, 5
    syscall 
    ret


printNumber:
    push rax
    push rdx
    xor rdx, rdx        ;clear rdx
    div qword[const10]  ;rax = quotient, rdx = remainder
    test rax, rax       ;== quotient zero?
    je .char_convert    
    call printNumber    ;Display the quotient
.char_convert  :
    lea rax, [rdx + '0']      ;rax = rdx + '0' //number to ascii
    call print_character    ;Display the remainder
    pop rdx
    pop rax
    ret

print_character:
    push rax            ;push the Character in stack

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, rsp        ;rsi = address of Character 
    mov rdx, 1
    syscall

    pop rax 
    ret

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


exit_program:
    mov rax, 60
    mov rdi, 0
    syscall
