data segment
        msg DB "Enter number to display$"
data ends
code segment
        assume cs:code,ds:data
        start:
        mov AX,data
        mov ds,AX
        lea DX,msg
        mov AH,09H
        INT 21H
        mov AH,01H
        INT 21H
        mov DL,AL
        mov AH,02H
        INT 21H
        mov AH,4CH
        INT 21H
code ends
end start
