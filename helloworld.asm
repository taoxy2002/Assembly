DATAS  SEGMENT;定义数据段 DATAS
     STRING  DB  'Hello World!',13,10,'$';定义数据 STRING
DATAS  ENDS;数据段

CODES  SEGMENT;定义代码段 CODES
     ASSUME    CS:CODES,DS:DATAS;确定CS和DS指向的逻辑段
     
START:
     MOV  AX,DATAS;DATAS相当于是立即数，不能用立即数对段寄存器直接赋值
     MOV  DS,AX;装填DS寄存器
     LEA  DX,STRING;利用LEA指令取偏移地址，将DX指向段首
     MOV  AH,9;DOS 9号功能调用
     INT  21H;显示指定的字符串
   
     MOV  AH,4CH;结束程序，返回DOS功能调用
     INT  21H
CODES  ENDS
    END   START
