data segment
        msg DB "Hello World$"
data ends

code segment
        assume cs:code,ds:data
        start:
        MOV AX,data
        MOV ds,AX
        LEA DX,msg
        MOV AH,09H
        INT 21H
        MOV AH,4CH
        INT 21H
code ends
end start
