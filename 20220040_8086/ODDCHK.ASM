data segment
    num db ?
    msg1 db 10,13,"Enter Number: $"
    msg2 db 10,13,"The number is odd$"
    msg3 db 10,13,"The number is even$"
    count db ?
data ends
code segment
    assume cs:code,ds:data
    start:
    mov ax,data
    mov ds,ax

    ;Read Number
    lea si,msg1
    call output
    call input
    mov num,al

    ;Check Odd
    mov ah,00h
    mov bl,02H
    div bl
    cmp ah,00h
    je divbyzero
    lea si,msg2
    call output
    jmp exit
    divbyzero:lea si,msg3
    call output

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