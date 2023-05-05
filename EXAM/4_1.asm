;4.	现有一组字符串为data,name,time,file,code,path,user,exit,quit,text，
;请编写程序从键盘输入4个字符的字符串，若存在将其修改为disk, 并将结果在显示器上显示
DATAS SEGMENT
    STRING DB 'data','$','name','$','time','$','file','$','code','$','path','$','user','$','exit','$','quit','$','text','$'
    INPUT DB 5,6 DUP (0)
    BUFFER DB 4 DUP(0)
    CHANGE DB 'disk'
    FLAG DB 0
    CR_LF DB 0DH,0AH,'$'
    INFO1 DB 'INPUT:$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;INPUT
    LEA DX,INFO1
    MOV AH,9
    INT 21H
    
    LEA DX,INPUT
    MOV AH,0AH
    INT 21H
    ;TO BUFFER
    LEA SI,INPUT[2]
    LEA DI,BUFFER
    MOV CX,4
TOBUFFER:
	MOV AL,[SI]
	MOV [DI],AL
	INC SI
	INC DI
	LOOP TOBUFFER
	;COMPARE
	LEA SI,STRING
	MOV CX,10
CMP1:
	CALL COMP
	CMP FLAG,0
	JE GO
	
	;make change
	LEA DI,CHANGE
	MOV AL,[DI]
	MOV [SI],AL
	
	MOV AL,[DI+1]
	MOV [SI+1],AL
	
	MOV AL,[DI+2]
	MOV [SI+2],AL
	
	MOV AL,[DI+3]
	MOV [SI+3],AL
		
GO:
	ADD SI,5
	LOOP CMP1	  
  
  	;显示
  	MOV CX,10
  	LEA SI,STRING
DISP:
	MOV DX,SI
	MOV AH,9
	INT 21H
	
	LEA DX,CR_LF
	MOV AH,9
	INT 21H
	
	ADD SI,5
	
	LOOP DISP
    
    
    MOV AH,4CH
    INT 21H

;比较连续的四位,SI,DI
COMP PROC
	MOV FLAG,0
	LEA DI,BUFFER
	MOV AL,[DI]
	CMP [SI],AL
	JNE BACK
	
	MOV AL,[DI+1]
	CMP [SI+1],AL
	JNE BACK
	
	MOV AL,[DI+2]
	CMP [SI+2],AL
	JNE BACK
	
	MOV AL,[DI+3]
	CMP [SI+3],AL
	JNE BACK
	
	;EQUAL
	MOV FLAG,1
	RET
	;NOT EQUAL
	BACK:
	MOV FLAG,0
	RET
	
COMP ENDP
CODES ENDS
    END START
