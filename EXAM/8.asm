;8.	键盘输入一个二进制数（字类型），以十六进制的形式输出
DATAS SEGMENT
    INPUT DW 0
    OUTPUT DB 4 DUP(0),'$'
    BUFFER DB 17,16 DUP(0)
    STRING1 DB 'INPUT BIN:$'
    STRING2 DB 'OUTPUT HEX:$'
    MUL_NUM DW 2
    CR_LF DB 0DH,0AH,'$'
    FLAG DB 1
    DIV_NUM DW 16
DATAS ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;输入提示
    LEA DX,STRING1
    MOV AH,9
    INT 21H

    ;一次输入十进制数，分别乘上权重
	LEA DX,BUFFER
    MOV AH,0AH
    INT 21H

    MOV CX,0
    MOV CL,BUFFER[1]
    LEA SI,BUFFER[2]

    ;CX为循环的次数,输入16位二进制数,将输入字符串数据存入字类型的INPUT
INP:
    MOV AX,INPUT
    MUL MUL_NUM
    MOV BL,[SI]
    SUB BL,30H
    MOV BH,0
    ADD AX,BX
    MOV INPUT,AX
    INC SI
    LOOP INP

    LEA DX,STRING2
    MOV AH,9
    INT 21H

    MOV CL,4
    ;1
    MOV BX,INPUT
    SHR BH,CL
    MOV BL,BH
    CALL HEX2ASC
    MOV AH,2
    INT 21H

    MOV CL,4
    ;2
    MOV BX,INPUT
    SHL BH,CL
    SHR BH,CL
    MOV BL,BH
    CALL HEX2ASC
    MOV AH,2
    INT 21H

    MOV CL,4
    ;3
    MOV BX,INPUT
    SHR BL,CL
    CALL HEX2ASC
    MOV AH,2
    INT 21H

    MOV CL,4
    ;4
    MOV BX,INPUT
    SHL BL,CL
    SHR BL,CL
    CALL HEX2ASC
    MOV AH,2
    INT 21H

    MOV AH,4CH
    INT 21H

;放到BL中判断,输出直接给AL
HEX2ASC PROC
    CMP BL,10
    JAE NEXT
    MOV DL,BL
    ADD DL,30H
    RET
NEXT:
    MOV DL,BL
    ADD DL,55
    RET
HEX2ASC ENDP

CODES ENDS
    END START
