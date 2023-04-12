;4.	现有一组字符串为data,name,time,file,code,path,user,exit,quit,text，
;请编写程序从键盘输入4个字符的字符串，若存在将其修改为disk, 并将结果在显示器上显示。

DATAS SEGMENT
    STRING DB 'data,name,time,file,code,path,user,exit,quit,text$'
    len_string  EQU  $ - string
    STRING1 DB 'Input string:$' 
    STRING2 DB 'Output string:$'
    BUFFER DB 5,6 DUP (0)
    STRING_OUTPUT DB 100 DUP(0)
    CR_LF DB 0DH,0AH,'$'
    FLAG DB 0
    DISK DB 'DISK'
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

	CALL COMP
	
    LEA DX,STRING
    MOV AH,9
    INT 21H
    
    LEA DX,CR_LF
    MOV AH,9
    INT 21H
    
    MOV AH,4CH
    INT 21H

;cx已经存好
COMP  PROC
    MOV DX,DI
    LOP:
    ;1
    MOV AL,[DI]
    CMP [SI],AL
    JNE NEXT

    ;2
    INC SI
    INC DI
    MOV AL,[DI]
    CMP [SI],AL
    JNE NEXT
    
    ;3
    INC SI
    INC DI
    MOV AL,[DI]
    CMP [SI],AL
    JNE NEXT

    ;
    INC SI
    INC DI
    MOV AL,[DI]
    CMP [SI],AL
    JNE NEXT

MATCH:
    SUB SI,3
    MOV AL,'d'
    MOV [SI],AL
    MOV AL,'i'
    MOV [SI+1],AL
    MOV AL,'s'
    MOV [SI+2],AL
    MOV AL,'k'
    MOV [SI+3],AL
    RET
    
NEXT:
    INC SI
    MOV DI,DX

    LOOP LOP
    RET
COMP  ENDP
CODES ENDS
    END START
