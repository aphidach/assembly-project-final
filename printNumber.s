section .data
    STDOUT	equ	1
    STDERR 	equ	2	
    SYS_write equ 1

    const10 dq 10
section .text
;this function need int in rax
;and do
; -convert to string
; -print that string each char

global printNumber
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
