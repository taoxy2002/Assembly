;13.如果是回文串，输出yes，否则输出no。回文串就是正读和反读都一样的字符串，如level和noon。
DATAS SEGMENT
    STRING  DB 20,21 DUP(0),'$'
    STRING1 DB 'Input:$'
    STRING2 DB 'yes$'
    STRING3 DB 'no$'
    CR_LF DB 0DH,0AH,'$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    LEA DX,STRING1
    MOV AH,9
    INT 21H

    LEA DX,STRING
    MOV AH,0AH
    INT 21H

     LEA DX,CR_LF
    MOV AH,9
    INT 21H

    ;SI指向起始 DI指向结束
    LEA SI,STRING[2]
    MOV CX,0
    MOV CL,STRING[1]
    MOV DI,SI
    ADD DI,CX
    DEC DI

GO:
    MOV BL,[DI]
    CMP [SI],BL
    JNE OUT1

    MOV AX,DI
    SUB AX,SI
    INC SI
    DEC DI
    CMP AX,1
    JA GO
    LEA DX,STRING2
    MOV AH,9
    INT 21H

    LEA DX,CR_LF
    MOV AH,9
    INT 21H

    MOV AH,4CH
    INT 21H

OUT1:
    LEA DX,STRING3
    MOV AH,9
    INT 21H

    LEA DX,CR_LF
    MOV AH,9
    INT 21H

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
