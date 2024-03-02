global _start

section .data
    div_ANS dq 0
    div_rem dq 0

section .text
_start:
    mov rdx, 0
    mov rax, 66 ;divide 66
    mov rbx, 7 ;by 7
    div rbx ;rax = 9, rdx = 3
    call div_result ;call subroutine to display result 

    mov rax, 60
    mov rdi, 0
    syscall

div_result:
    push rax
    push rdx
    push rbx

    ;req 3 agument 
        ;rdx req reminder from div
        ;rbx for find the reminder 4 point
        ;rax req answer for show ANS
    mov qword[div_ANS], rax

    mov rax, rdx ;for find rem by div
    imul rax, 10000 ;for calculate 4 point floting
    mov rdx, 0 ; clear rdx for div rax only
    div rbx ;rax = rem 4 point

    mov qword[div_rem], rax
    ;Result  qword[div_ANS].qword[div_rem]

    ;mov 1's arugment, qword[div_ANS]
    ;mov 2's arugment, qword[div_rem]
    ;call showresutl ;call subroutine to display result 
endmodule:
    pop rbx
    pop rdx
    pop rax
    ret