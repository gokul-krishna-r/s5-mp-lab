data segment
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13,"Enter String 1: $"
    msg2 db 10,13,"ENter String 2: $"
    msg3 db 10,13,"Two Strings are equal$"
    msg4 db 10,13,"Two Strings are not equal $"
data ends
code segment
    assume cs:code,ds:data
    start:
    mov ax,data
    mov ds,ax
    
    
    ;Read String 1
    lea si,msg1
    call output
    mov si,offset str1
    call input

    ;Read String 2
    lea si,msg2
    call output
    mov si,offset str2
    call input

    ;Compare Strings
    mov si,offset str1+2
    mov di,offset str2+2
    mov cl,str1+1
    mov ch,str2+1
    cmp cl,ch
    jne noteq
    repeat:mov ah,[si]
    mov al,[di]
    cmp ah,al
    jne noteq
    inc si
    inc di
    dec cl
    jnz repeat
    mov si,offset msg3
    call output
    jmp exit

    noteq:mov si,offset msg4
    call output
    jmp exit
    
    exit:mov ah,4CH
    int 21H
    input proc near
        mov ah,0AH
        mov dx,si
        int 21H
        ret
    input endp
    output proc near
        mov ah,09H
        mov dx,si
        int 21H
        ret
    output endp

code ends
end start