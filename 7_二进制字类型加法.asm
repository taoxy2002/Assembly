data segment
	FIRST     	DW  758DH,9A5CH
	SECOND  	DW  0A524H,8345H
	THIRD     	DW  3   DUP(0)
data ends

code segment
	assume cs:code,ds:data,es:data
main proc  far
	MOV ax,data
	MOV ds,ax
	LEA SI,FIRST     ;取加数的有效地址
	LEA DI,SECOND    ;取被加数的有效地址
	LEA BX,THIRD     ;取存放和的有效地址
	MOV AX,[SI]      ;取加数的第一个字
	ADD AX,[DI]      ;与被加数的第一个字相加
	MOV [BX],AX      ;存第一次运算的部分和
	PUSHF             ;保护标志位
	ADD SI,2  ;加数地址加2,指向下一加数的地址,字类型
	ADD DI,2  ;被加数地址加2,指向下一被加数的地址
	ADD BX,2  ;和地址加2,指向下一部分和的地址
	POPF           ;恢复标志位
	MOV AX,[SI]   ;从加数中取出第二个字
	ADC AX,[DI]   ;与被加数的第二个字进行带进位相加
	MOV [BX],AX    ;存第二次部分和
	ADC WORD PTR [BX+2],0 ;将进位存入和的第三字中

	MOV ah,4ch
	int 21h
	main endp
code ends
	end main
