;17 键盘输入一串二进制数1ah ，7ch，0bah，3ah，45h，63h求其和，并将结果显示在屏幕上。
DATAS SEGMENT
    INPUT DB 4, 5 DUP(0) 
    OUTPUT DW 0
    STRING1 DB 'Keyboard Input:1ah,7ch,0bah,3ah,45h,63h:',0DH,0AH,'$'
    BUFFER DB 0
    message db 'sum:'
    SUM DW 0
    MUL_NUM DW 16
    
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

    MOV CX,6
    
LOP:    
    MOV BP,CX;计数器保护
    LEA DX,INPUT
    MOV AH,0AH
    INT 21H
    mov ch,0
    MOV CL,INPUT[1]
    LEA SI,Input[2]
    MOV BUFFER,0
    MOV AX,0
    
INP:
    MUL MUL_NUM
    MOV BL,[SI]
    CMP BL,39H
    JA LETTER
    SUB BL,30H
    JMP continue
    LETTER:
    sub bl,'a'-10
    continue:
    ADD AL,BL
    INC SI
LOOP INP
    ;MOV BUFFER,AX
    ADD SUM,AX

    MOV CX,BP

    LEA DX,CR_LF
    MOV AH,9
    INT 21H

    LOOP LOP

    ;1
    MOV AX,SUM
    MOV CL,4
    SHR AH,CL
    MOV DL,AH
    CMP DL,10
    jae a
    ADD DL,30H
    jmp a1
    a:
    ADD DL,'a'-10
    a1:
    mov ah,2
    int 21h

    ;2
    MOV AX,SUM
    MOV CL,4
    shl AH,CL
    shr ah,cl
    MOV DL,AH
    CMP DL,10
    jae b
    ADD DL,30H
    jmp b1
    b:
    ADD DL,'a'-10
    b1:
    mov ah,2
    int 21h

    ;3
    MOV AX,SUM
    MOV CL,4
    shr al,cl
    MOV DL,al
    CMP DL,10
    jae c
    ADD DL,30H
    jmp c1
    c:
    ADD DL,'a'-10
    c1:
    mov ah,2
    int 21h

    ;4
    MOV AX,SUM
    MOV CL,4
    shl al,cl
    shr al,cl
    MOV DL,al
    CMP DL,10
    jae d
    ADD DL,30H
    jmp d1
    d:
    ADD DL,'a'-10
    d1:
    mov ah,2
    int 21h

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
