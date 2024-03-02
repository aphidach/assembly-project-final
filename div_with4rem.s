global _start

section .data
    div_ANS dq 0
    div_rem dq 0

    msg db "Num "
    len_msg equ ($-msg)
    dot db "."
    const10 dq 10

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

    mov rax, rdx    ;for find rem by div
    imul rax, 10000 ;for calculate 4 point floting
    mov rdx, 0      ; clear rdx for div rax only
    div rbx         ;rax = rem 4 point

    mov qword[div_rem], rax
    ;Result  qword[div_ANS].qword[div_rem]

    ;mov 1's arugment, qword[div_ANS]
    ;mov 2's arugment, qword[div_rem]
    call showresult ;call subroutine to display result 
endmodule:
    pop rbx
    pop rdx
    pop rax
    ret


showresult:
    mov rax, qword[div_ANS]
    mov rdx, 0
    call printNumber

    mov rax, 1
    mov rdi, 1
    mov rsi, dot
    mov rdx, 1
    syscall

    mov rax, qword[div_rem]
    mov rdx, 0
    call printNumber    
    ret
printNumber:
    push rax
    push rdx
    xor rdx, rdx        ;rdx:rax = number
    div qword[const10]  ;rax = quotient, rdx = remainder
    test rax, rax       ;Is quotient zero?
    je .l1              ;yes, don't display it
    call printNumber    ;Display the quotient
.l1:
    lea rax, [rdx+'0']
    call printCharacter  ;Display the remainder
    pop rdx
    pop rax
    ret

printCharacter:
    push rax
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    pop rax
    ret