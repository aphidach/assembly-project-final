global _start

section .data
    msg db "Hello world! type",10
    len_msg equ ($-msg)

section .text
_start:
    mov rax,1
    mov rdi,1
    mov rsi,msg
    mov rdx,len_msg
    syscall

    mov rax,60
    mov rdi,0
    syscall