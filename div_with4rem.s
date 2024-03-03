global _start

section .data
    STDOUT	equ	1
    STDERR 	equ	2	
    SYS_write equ 1

    div_ANS dq 0
    div_rem dq 0

    dot db "."
    ENDLINE db "",10
    const10 dq 10

section .text
_start:
    mov rdx, 0
    mov rax, 589    ;dividend
    mov rbx, 7      ;divisor
    div rbx         ;rax = quotient, rdx = remainder
    call div_result ;call subroutine to display result 

    mov rax, 60
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
    mov rdx, 0
    call printNumber   

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, ENDLINE
    mov rdx, 1
    syscall 
    ret

printNumber:
    push rax
    push rdx
    xor rdx, rdx        ;rdx:rax = number
    div qword[const10]  ;rax = quotient, rdx = remainder
    test rax, rax       ;== quotient zero?
    je .char_convert    
    call printNumber    ;Display the quotient
.char_convert  :
    lea rax, [rdx+'0']
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