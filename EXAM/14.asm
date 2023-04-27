;14.从键盘输入一串可显示字符（以回车符结束），并按字母、数字、空格分类计数，然后显示出这三类统计的结果
DATAS SEGMENT
    BUFFER DB 100,101 DUP(0)
    STRING1 DB 'INPUT:$'
    CR_LF DB 0DH,0AH,'$'
    LETTERS DB 0
    NUMBERS DB 0
    SPACES DB 0
    STRING2 DB 'LETTER:$'
    STRING3 DB 'NUMBER:$'
    STRING4 DB 'SPACE:$'
    DIV_NUM DW 10
    TEMP DB 3 DUP(0),'$'
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

    LEA DX,BUFFER
    MOV AH,0AH
    INT 21H

    LEA DX,CR_LF
    MOV AH,9
    INT 21H
    
    MOV CX,0
    MOV CL,BUFFER[1]
    LEA SI,BUFFER[2]

LOP:
    CMP BYTE PTR [SI],'0'
    JB SPACE
    CMP BYTE PTR [SI],'0'
    JB CONTINUE
    CMP BYTE PTR [SI],'9'
    JBE NUMBER
    CMP BYTE PTR [SI],'A'
    JB CONTINUE
    CMP BYTE PTR [SI],'Z'
    JBE LETTER
    CMP BYTE PTR [SI],'a'
    JB CONTINUE
    CMP BYTE PTR [SI],'z'
    JBE LETTER

SPACE:
    CMP BYTE PTR [SI],' '
    JNE CONTINUE
    INC SPACES
    JMP CONTINUE

NUMBER:
    INC NUMBERS
    JMP CONTINUE

LETTER:
    INC LETTERS

CONTINUE:
    INC SI
    LOOP LOP

    ;字母
    LEA DX,STRING2
    MOV AH,9
    INT 21H

    MOV AX,0
    MOV AL,LETTERS
    CALL DISP

    ;数字
    LEA DX,STRING3
    MOV AH,9
    INT 21H
    
    MOV AX,0
    MOV AL,NUMBERS
    CALL DISP

    ;空格
    LEA DX,STRING4
    MOV AH,9
    INT 21H

    MOV AX,0
    MOV AL,SPACES
    CALL DISP

    MOV AH,4CH
    INT 21H

;AL
DISP PROC
    ;MOV CX,3
    LEA SI,TEMP[2]
DIS:
    MOV DX,0
    DIV DIV_NUM
    ADD DL,30H
    MOV [SI],DL
    DEC SI
    CMP AX,0
    JNZ DIS

    LEA DX,TEMP
    MOV AH,9
    INT 21H

    LEA DX,CR_LF
    MOV AH,9
    INT 21H

    RET
CODES ENDS
    END START
