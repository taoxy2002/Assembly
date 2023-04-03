DATA SEGMENT
  DB 41H;偏移量0 A
  DB 42H;偏移量1 B
  DB 0DH;回车
  DB 0AH;换行
DATA ENDS
CODE SEGMENT
  ASSUME CS: CODE, DS: DATA
GO: 	MOV AX,DATA
        MOV DS,AX
        MOV DL,DS:[0];
        MOV AH,2
        INT 21H
        MOV DL,DS:[1];直接寻址
        INT 21H
        MOV DL,DS:[2];
        INT 21H
        MOV DL,DS:[3];
        INT 21H
        MOV AH,4CH
        INT 21H
CODE ENDS
  END GO               
