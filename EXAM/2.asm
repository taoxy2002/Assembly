;2.	请任意输入一个字符串，将其中大写字母换成小写字母，并将结果显示在屏幕上
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
    MOV BL,STRING[SI]
    CMP BL,'A'
    JB NOT_CAP
    CMP BL,'Z'
    JA NOT_CAP
    ADD BL,32
    MOV [DI],BL
    JMP CONTINUE
   
NOT_CAP:

    MOV [DI],BL

CONTINUE:
    INC SI
    INC DI
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

	LEA DX,CR_LF
    MOV AH,9
    INT 21H
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
