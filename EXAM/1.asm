;1.	请任意输入一个字符串，将其中A换成CC，并将结果显示在屏幕上
DATAS SEGMENT
    STRING DB 100,101 DUP(0)
    STRING1 DB 'Input string:$' 
    STRING2 DB 'Output string:$'
    STRING_OUTPUT DB 100 DUP(0)
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
    ;显示输入提示string1
    LEA DX,STRING1
    MOV AH,9
    INT 21H
    
    ;输入字符串
    LEA DX,STRING
    MOV AH,0AH
    INT 21H

    ;设置计数器
    MOV CX,0
    MOV CL,STRING[1]
    LEA SI,STRING[2]
    LEA DI,STRING_OUTPUT
MOVE:
    MOV AL,STRING[SI]
    CMP AL,'A'
    JNE NOT_A
    MOV BL,'C'
    MOV [DI],BL
    INC DI
    MOV [DI],BL
    INC DI
    JMP CONTINUE
NOT_A:
    MOV [DI],AL
    INC DI
CONTINUE:
    INC SI
LOOP MOVE
   MOV BYTE PTR [DI] ,'$'

    ;显示输入提示string2
    LEA DX,STRING2
    MOV AH,9
    INT 21H

    ;输出结果
    LEA DX,STRING_OUTPUT
    MOV AH,9
    INT 21H

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
