;convert 0-9 to string
convert:
    ;push rax
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
    ;pop rax
    ret  


