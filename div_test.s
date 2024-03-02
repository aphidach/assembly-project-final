global _start

section .data
    msg db "Hello world!",10
    len_msg equ ($-msg)

    err_msg db "Error",10
    len_err_msg equ ($-err_msg)

    div_ANS dq 0
    div_rem dq 0
    divBy dq 0

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len_msg
    syscall

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

    mov qword[div_ANS], rax
    mov qword[div_rem], rdx
    mov qword[divBy], rbx

    mov rax, rdx ;for find rem by div
    imul rax, 10000 ;for calculate 4 point floting
    mov rdx, 0 ; clear rdx for div rax only
    div rbx ;rax = rem 4 point


    ;on debug -----------------------------VVVVVV---------------------------------
    mov rax, 1
    mov rdi, 1
    mov rsi, err_msg ;should convert to string first :feture on going
    mov rdx, len_err_msg
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, err_msg ;should convert to string first :feture on going
    mov rdx, len_err_msg
    syscall


    mov rax, 1
    mov rdi, 1
    mov rsi, qword[div_ANS]
    mov rdx, 2
    ;call convert
    syscall
    ;on debug -----------------------------^^^^^^---------------------------------

endmodule:
    pop rbx
    pop rdx
    pop rax
    ret


;convert 0-9 to string
convert:
    push rax
    ;push rsi
    ;push rdi

    mov rax, 0              ; Set initial total to 0

    movzx rsi, byte [rdi]   ; Get the current character
    test rsi, rsi           ; Check for \0
    je done
    
    cmp rsi, 48             ; Anything less than 0 is invalid
    jl error
    
    cmp rsi, 57             ; Anything greater than 9 is invalid
    jg error
     
    sub rsi, 48             ; Convert from ASCII to decimal 
    imul rax, 10            ; Multiply total by 10
    add rax, rsi            ; Add current digit to total
    
    inc rdi                 ; Get the address of the next character
    jmp convert

error:
    ; console error
    mov rax, 1
    mov rdi, 1
    mov rsi, err_msg
    mov rdx, len_err_msg
    syscall            
 
done:
    ;pop rdi
    ;pop rsi
    pop rax
    ret  


