;5.	现有一组字符串为data,name,time,file,code,path,user,exit,quit,text，
;请编写程序从键盘输入4个字符的字符串，若存在将其删除, 并在显示器上显示。

DATAS SEGMENT
    STRING DB 'data,name,time,file,code,path,user,exit,quit,text'
    len_string  EQU  $ - string
    STRING1 DB 'Input string:$' 
    STRING2 DB 'Output string:$'
    BUFFER DB 5,6 DUP (0)
    ;STRING_OUTPUT DB 100 DUP(0)
    CR_LF DB 0DH,0AH,'$'
    FLAG DB 0
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV CX,len_string

    LEA DX,STRING1
    MOV AH,9
    INT 21H

    ;输入字符串
   	LEA DX,BUFFER
    MOV AH,0AH
    INT 21H

    MOV CX,len_string
    LEA SI,STRING
    LEA DI,BUFFER[2]

    LEA DX,STRING2
    MOV AH,9
    INT 21H

CHECK:
    MOV DL,[SI]
	CALL COMP
    CMP FLAG,0
    JE DISP
    ADD SI,4
    JMP N

DISP:
    MOV AL,DL
    MOV AH,2
    INT 21H
    INC SI
N:
LOOP CHECK

    LEA DX,CR_LF
    MOV AH,9
    INT 21H

    MOV AH,4CH
    INT 21H

;cx已经存好
COMP  PROC

    ;1
    MOV AL,[DI]
    CMP [SI],AL
    JNE NEXT

    ;2
    MOV AL,[DI+1]
    CMP [SI+1],AL
    JNE NEXT
    
    ;3
    MOV AL,[DI+2]
    CMP [SI+2],AL
    JNE NEXT

    ;
    MOV AL,[DI+3]
    CMP [SI+3],AL
    JNE NEXT
MATCH:
    MOV FLAG,1
    RET 
NEXT:
    MOV FLAG,0
    RET

COMP  ENDP

CODES ENDS
    END START
