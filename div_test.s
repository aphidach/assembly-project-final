global _start

section .data
    msg db "Hello world!",10
    len_msg equ ($-msg)

    err_msg db "Error",10
    len_err_msg equ ($-err_msg)

    div_ANS dq 0
    div_rem dq 0

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

    mov qword[div_ANS], rax
    mov qword[div_rem], rdx

    ;on debug -----------------------------VVVVVV---------------------------------
    mov rax,1
    mov rdi,1
    mov rsi, err_msg ;should convert to string first :feture on going
    mov rdx,len_err_msg
    syscall

    mov rax,1
    mov rdi,1
    mov rsi, err_msg ;should convert to string first :feture on going
    mov rdx,len_err_msg
    syscall
    ;on debug -----------------------------^^^^^^---------------------------------

endmodule:
    pop rdx
    pop rax
    ret


;convert 0-9 to string
convert:
    push rax
    push rsi
    push rdi

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
    ; console on error
    mov rax,1
    mov rdi,1
    mov rsi,err_msg
    mov rdx,len_err_msg
    syscall            
 
done:
    pop rdi
    pop rsi
    pop rax
    ret  


