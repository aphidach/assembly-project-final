global _start

section .data
    msg db "Hello world!",10
    len_msg equ ($-msg)

section .text
_start:
    mov rax,1
    mov rdi,1
    mov rsi,msg
    mov rdx,len_msg
    syscall

    mov rdx, 0
    mov rax, 7 ;divide 7
    mov rbx, 5 ;by 5
    div rbx ;rax = ANS, rdx = rem
    call div_result ;call subroutine to display result 

    mov rax,60
    mov rdi,0
    syscall

div_result:
    push rax
    push rdx


endmodule:
    pop rdx
    pop rax
    ret