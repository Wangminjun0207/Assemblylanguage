;;求字符串空格数
DATA SEGMENT
    STRING DB 100,0,100 DUP(0)
    COUNT DB 0
    STR DB 'Number of space key: $'
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA 
START:
    MOV AX, DATA
    MOV DS, AX
    LEA DX, STRING ;输入字符串
    MOV AH, 0AH
    INT 21H
    
    MOV DL, 0DH
	MOV AH, 02H
	INT 21H
	MOV DL, 0AH 
	MOV AH, 02H
	INT 21H
    MOV AH, 0DH    ;回车ASCII码
    LEA SI, STRING+2 ;SI指到第一个有效字符
NEXT:
    MOV AL, [SI]  
    INC SI
    CMP AL, AH    ;判断是否是字符串结尾
    JZ PRINT
    CMP AL, ' '   ;判断是否是空格
    JZ INCCOUNT
    JMP NEXT
INCCOUNT:
    INC COUNT
    JMP NEXT
PRINT:
    LEA DX, STR
    MOV AH, 09H
    INT 21H
    MOV AH, 0 
    LEA DI, COUNT
	MOV AL, [DI] ;空格的个数放到寄存器AL
	MOV DL, 10   ;除数放到寄存器DL
	DIV DL
	MOV DL, AL   ;个数的十位
	ADD DL, 30H
	MOV DH, AH   ;个数的个位
	MOV AH, 02H  ;十位输出
	INT 21H
	ADD DH, 30H
	MOV DL, DH   ;个位输出
	MOV AH, 02H
	INT 21H
EXIT:
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START