global zero_precheck

section .data
    STDOUT	equ	1
    STDERR 	equ	2	
    SYS_write equ 1

    zero db "A"
    rangeZero dq 9999
    const10 dq 10
section .text
;use to check zer prefix
;req in pass rax
;the rangeZero varible use to choose rage for example 
;ragneZero = 9999 output is 0000 000x 00xx 0xxx xxxx
;ragneZero = 999 output is 000 00x 0xx xxx

zero_precheck:
    push rax
    push rbx
    push rdx

    test rax, rax               ;rax == 0?
    je .endCheck

    mov rbx, rax                ;swap
    mov rax, 9999               ;start 4 digi

.zero_runC
    xor rdx, rdx                ;clear
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