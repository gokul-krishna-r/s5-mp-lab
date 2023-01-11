data segment
    num1 db ?
    num2 db ?
    msg1 db 10,13,"Enter Number 1 : $"
    msg2 db 10,13,"Enter Number 2 : $"
    msg3 db 10,13,"The average is : $"
    result db ?
data ends
code segment
    assume cs:code,ds:data
    start:
    mov ax,data
    mov ds,ax

    ;Read Number 1
    lea si,msg1
    call output
    call input
    mov num1,al

    ;Read Number 2
    lea si,msg2
    call output
    call input
    mov num2,al

    ;Take Avg
    mov al,num1
    add al,num2
    mov ah,00H
    mov bl,02H
    div bl
    mov result,al
    
    lea si,msg3
    call output

    mov al,result
    and al,0f0h
    mov cl,04H
    rol al,cl
    add al,30H
    cmp al,39H
    jle skip3
    add al,07H
    skip3:mov dl,al
    mov ah,02H
    int 21H

    mov al,result
    and al,0fh
    add al,30H
    cmp al,39H
    jle skip4
    add al,07H
    skip4:mov dl,al
    mov ah,02H
    int 21H

    exit: mov ah,4CH
    int 21H

    
    ;Input Procedure
    input proc near
        mov ah,01H
        int 21H
        sub al,30H
        cmp al,09H
        jle skip1
        sub al,07H
        skip1:mov cl,04H
        rol al,cl
        mov ch,al

        mov ah,01H
        int 21H
        sub al,30H
        cmp al,09H
        jle skip2
        sub al,07H
        skip2:add al,ch

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