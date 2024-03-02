global _start

section .data
    div_ANS dq 0
    div_rem dq 0

    dot db "."
    ENDLINE db "",10
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

    mov rax, 1
    mov rdi, 1
    mov rsi, ENDLINE
    mov rdx, 1
    syscall 
    ret

printNumber:
    push rax
    push rdx
    xor rdx, rdx        ;rdx:rax = number
    div qword[const10]  ;rax = quotient, rdx = remainder
    test rax, rax       ;Is quotient zero?
    je .char_convert    
    call printNumber    ;Display the quotient
.char_convert  :
    lea rax, [rdx+'0']
    call print_character;Display the remainder
    pop rdx
    pop rax
    ret

print_character:
    push rax            ;push the Character in stack

    mov rax, 1
    mov rdi, 1
    mov rsi, rsp        ;rsi = addressof Character 
    mov rdx, 1
    syscall

    pop rax 
    ret