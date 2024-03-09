global _start

section .data
    STDOUT	equ	1
    STDERR 	equ	2	
    SYS_write equ 1

    div_ANS dq 0
    div_rem dq 0

    dot db "."
    ENDLINE db "",10
    four_zero db "0000",10
    const10 dq 10
    zero db "0"

extern print_start_msg
extern print_output_msg
extern get_numOne
extern get_numTwo

extern printNumber

section .text
_start:
    ;req user input
    call print_start_msg 
    
    call get_numOne ;dividend
    push rax
    call get_numTwo ;divisor
    push rax    
    
    pop rbx         ;divisor
    pop rax         ;dividend
    xor rdx, rdx    ;clear rdx for div rax only
    div rbx         ;rax = quotient, rdx = remainder
    call div_result ;call subroutine to display result 

    mov rax, 60     ;exit
    mov rdi, 0
    syscall

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

    ;print "Output = "
    call print_output_msg
    ;1's arugment is qword[div_ANS]
    ;2's arugment is qword[div_rem]
    call showresult ;call subroutine to display result 

    pop rbx
    pop rdx
    pop rax
    ret

showresult:
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
    call zero_precheck      ;check if remainder has 0 prefix
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

zero_precheck:
    push rax
    push rbx
    push rdx

    test rax, rax
    je .endCheck

    mov rbx, rax
    mov rax, 9999

.zero_runC
    xor rdx, rdx
    div qword[const10]
    test rax, rax
    je .endCheck

    cmp rbx, rax
    jg .endCheck

    push rax
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, zero
    mov rdx, 1
    syscall 
    pop rax
    jmp .zero_runC

.endCheck
    pop rdx
    pop rbx
    pop rax
    ret