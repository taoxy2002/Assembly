
DATAS SEGMENT
    ;此处输入数据段代码  
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV BX,1F1FH;修改BX内容
    MOV CH,4;counter
rotate:  mov  cl, 4
         rol  bx, cl    ;循环左移，移动并填补空位
         mov  al, bl
         and  al, 0fh
         add  al, 30h   ; ’0’~’9’ ASCII 30H~39H
         cmp  al, 3ah
         jl   printit
         add  al, 7h    ; ’A’~’F’ ASCII 41H~46H
printit: mov  dl, al
         mov  ah, 2
         int  21h
         dec  ch
         jnz  rotate
 	
CODES ENDS
    END START
