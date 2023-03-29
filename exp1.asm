;数据段定义
DATA		SEGMENT  PARA  'DATA' ; PARA表示使用段对齐方式，即在内存中按照段的大小进行对齐
		    ORG	100H      ;伪操作，指定下一单元(指令或数据)的地址
B_BUF1		DB	'@',?										;定义字节类型变量
B_BUF2		DB	10,-4,0FCH,10,11001B,?,?,0
B_BUF3		DB	'COMPUTER'
B_BUF4		DB	01,'JAN',02,'FEB',03,'mar'
B_BUF5		DB	'1234aBcd'
B_BUF6		DB	10 DUP(0)
B_BUF7      DB  5 DUP (2 DUP('*'),3 DUP('5'))
W_BUF1		DW	0FFFDH										;定义字类型变量
W_BUF2		DW	-3
W_BUF3		DW	11001B
W_BUF4		DW	B_BUF4
W_BUF5		DW	B_BUF7-B_BUF1
W_BUF6		DW	1,2,3,4,5,3*20
W_BUF7      DW  5 DUp(0)
W_BUF8		DW	$
D_BUF1		DD	?											;定义双字类型变量
D_BUF2		DD	'PC'
D_BUF3		DD	1234,12,34
D_BUF4		DD	B_BUF4
D_BUF5      DD  W_BUF8-B_BUF7+1
Q_BUF1		DQ	?											;定义八字节类型变量
Q_BUF2		DQ	3C32H
Q_BUF3		DQ	1234H
T_BUF1		DT	?											;定义十字节类型变量
T_BUF2		DT	'PC'										
LEN		    DW	$
char1  	 	DB  100,0,101 dup(0)
char2  	 	DB  100,0,101 dup(0)
message1 	db 'Please input char : ','$'
message2 	db 'result            : ','$'
message3    db 'type to copy : ','$'
cr_lf    	db 0ah,0dh,'$'
DATA		ENDS
;堆栈段定义
STSEG       SEGMENT PARA STACK 'STACK'
			DB	256	DUP('#')      ;定义256个字节空间，
			                      ; 每个字节空间都放入字符#
STSEG 		ENDS
;数据段定义,附加段和数据段的地址默认情况下是相同的
EDATA		SEGMENT PARA 'DATA'
			MSD DB 	200H DUP('s')     ;存放读入数据的缓冲区
EDATA		ENDS
;代码段定义
CODE		SEGMENT PARA	'CODE'
            ASSUME CS:CODE,DS:DATA,SS:STSEG,ES:EDATA
MAIN		PROC	FAR
;初始化
			push ds
			xor ax,ax     ; 将AX清零,cf清零
			push ax
			MOV	AX,DATA
			MOV	DS,AX
			MOV	AX,EDATA    ;初始化的数据结束
			MOV	ES,AX
;寻址方式,顺序执行
           	mov bx,cx
           	mov cl,al
            mov bl,3
            mov bp,3003h                 ;bp：堆栈段基址的偏移量
            mov byte ptr es:[bx],-3      ;立即数寻址方式， byte ptr指令访问的内存单元是一个字节单元
                                         ; es:[bx],bx本应在ds中，段超越，立即数间接寻址
            mov word ptr es:[bx+1],-3    ;字单元
            mov b_buf1+1,0ah			 ;起始地址为100，这里b_buf1+1的地址为0101
            lea bx,b_buf6                ;基址寄存器BX,分析lea和offset的区别 EA=0126
            mov si,offset b_buf6         ;将b_buf6的首地址传送给si,该条指令运行完成后BX和SI寄存器相等        
            mov word ptr [bx],10000      ;10000D = 2710H
            mov [bx+2],cs       		 ;BX+2对应的EA为0128
            mov al, b_buf2
            mov ax,w_buf2    			 ;直接寻址方式

			clc
			std
			pushf
			lahf
			stc
			cld
			popf
;顺序、分支、循环、子程序调用和中断调用
;任意输入一串字符，将其中英文字母输出		
			call disp_letter				
			
;编写子程序，将自己定义一组数据复制到附加段
            call copy_data		
            		
			ret
;			MOV	AX,4C00H        ;退出
;			INT	21H
MAIN		ENDP
;显示英文字母子程序，程序执行到call disp_letter后，转到这里执行
disp_letter	proc near
    		lea dx,message1	;提示输入数据1
			mov ah,9        ;9号调用，用于字符显示
			int 21h
			lea dx,char1	;输入字符串,DS:DX=字符串的首地址	 
			mov ah,0ah
			int 21h	
			lea dx,cr_lf 	;回车换行
			mov ah,9
			int 21h		
			lea bx,char1
			inc bx	;寄存器bx值加一
            mov cl,[bx]
            mov ch,0  
            inc bx  ;寄存器bx值加一
            mov di,0       
AGAIN:		MOV	AL,[BX]        
            cmp al, 'A'        ;条件转移
            jb  not_char	   ;条件转移指令的判断条件会存在CF里，ASCII码比较大小，判断字符是何种类型
            cmp al,'z'
            ja  not_char
            cmp al,'a'
            jae is_char
            cmp al,'Z'
            ja  not_char
is_char: 	MOV	[DI],AL
			INC	di
not_char:	INC	bx
			loop AGAIN			;循环转移
			mov al,'$'
			mov [di],al
			lea dx,message2	
			mov ah,9
			int 21h
			mov dx,0	
			mov ah,9
			int 21h
			lea dx,cr_lf 	
			mov ah,9
			int 21h	               ;显示结果
			ret
disp_letter	endp

;完成数据复制子程序
copy_data	proc near
			lea dx,message3	;提示输入数据1
			mov ah,9
			int 21h
			lea dx,char2	;输入字符串	 
			mov ah,0ah
			int 21h	
			lea dx,cr_lf 	;回车换行
			mov ah,9
			int 21h		
			mov SI,offset char2  ;取输入地址
			mov DI,offset msd	;取地址
			next:
			;mov AL,DS[SI]
			;mov ES[DI],AL
			inc SI
			inc DI 
			dec CX 
						

			ret						;返回转移
copy_data	endp


CODE		ENDS
			END	MAIN		;程序结束   入口地址


IN		ENDP
;显示英文字母子程序
disp_letter	proc near
    		lea dx,message1	;提示输入数据1
			mov ah,9
			int 21h
			lea dx,char1	;输入字符串	 
			mov ah,0ah
			int 21h	
			lea dx,cr_lf 	;回车换行
			mov ah,9
			int 21h		
			lea bx,char1
			inc bx		
            mov cl,[bx]
            mov ch,0  
            inc bx 
            mov di,0       
AGAIN:		MOV	AL,[BX]
            cmp al, 'A'        ;条件转移
            jb  not_char
            cmp al,'z'
            ja  not_char
            cmp al,'a'
