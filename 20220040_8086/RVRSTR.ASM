data segment
    str1 db 20 dup('$')
    msg1 db 10,13,"Enter String: $"
    msg2 db 10,13,"Reverse String is: $"
    count db ?
data ends
code segment
    assume cs:code,ds:data
    start:
    mov ax,data
    mov ds,ax

    ;Read String
    lea si,msg1
    call output
    mov si,offset str1
    call input

    ;Reverse String
    mov si,offset msg2
    call output

    mov cl,str1+1 ; count
    mov si,offset str1 ; starting address
    repeat:inc si
    dec cl
    jnz repeat
    mov cl,str1+1
    inc si
    next:mov dl,[si]
    mov ah,02H
    int 21H
    dec si
    dec cl
    jnz next

    mov ah,4CH
    int 21H

    
    ;Input Procedure
    input proc near
        mov ah,0AH
        mov dx,si
        int 21H
        ret
    input endp

    ;Output Procedure
    output proc near
        mov ah,09H
        mov dx,si
        int 21H
        ret
    output endp
code ends
end start