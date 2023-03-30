DATA    SEGMENT
		S1  DB 'ABCDEFG'
		S2  DB '0123456'
		N   DW $-OFFSET S2    ;N为字符串长度
	DATA   ENDS
	CODE   SEGMENT
        ASSUME CS:CODE,DS:DATA
	START:MOV AX,DATA
        MOV DS,AX
        MOV SI,0
        MOV CX,N	;将字符的个数送至CX中
L1: MOV   AL,   S1[SI]
      XCHG AL,   S2[SI]
      MOV   S1[SI],AL;借助寄存器AL
      INC SI
      LOOP L1	 ;循环N次
      MOV AH,4CH
       INT 21H
CODE  ENDS
        END START
