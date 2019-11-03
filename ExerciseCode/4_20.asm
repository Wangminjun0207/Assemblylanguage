DATA SEGMENT
    STRING  DB 100,0, 100 DUP(0)
    DIGITAL DB 0
    LETTER  DB 0
    LENGTH  DB 0
    STR1    DB 'DIGITAL: $'
    STR2    DB 'LETTER : $'
    STR3    DB 'LENGTH : $'
DATA ENDS
CODE SEGMENT
	ASSUME CS: CODE, DS: DATA
START:
	MOV AX, DATA
	MOV DS, AX
	LEA DX, STRING
	MOV AH, 0AH ;字符串输入dos
	INT 21H
	MOV DL, 0DH
	MOV AH, 02H
	INT 21H
	MOV DL, 0AH
	INT 21H
	LEA SI, STRING+1
	MOV AL, [ SI]    ;字符串长度放到LENGTH单元
	MOV LENGTH, AL
	LEA SI, STRING+2
	MOV AH, 0DH
NEXT:
	MOV AL,[SI]
	CMP AL, AH      ;比较是否是回车字符
	JZ PRINT	
	CMP AL,30H      ;比较是否是数字字符
	JB JNEXT
	CMP AL,39H
	JBE TODIGITAL
	CMP AL,41H      ;比较是否是字母字符
	JB JNEXT
	CMP AL,5AH
	JBE TOLETTER
	CMP AL,61H      ;比较是否是字母字符
	JB JNEXT
	CMP AL,7AH
	JBE TOLETTER
JNEXT:
	INC SI
	JMP NEXT
TODIGITAL:
	INC DIGITAL
	JMP JNEXT
TOLETTER:
	INC LETTER
	JMP JNEXT
PRINT:
    LEA DX,STR1
    MOV AH, 09H
    INT 21H 
	LEA DI, DIGITAL
	MOV AH, 0
	MOV AL, [DI] ;digital的个数放到寄存器AX
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
	
	MOV DL, 0DH
	MOV AH, 02H
	INT 21H
	MOV DL, 0AH 
	MOV AH, 02H
	INT 21H
	         
	LEA DX,STR2
    MOV AH, 09H
    INT 21H
	LEA DI, LETTER
	MOV AH, 0
	MOV AL, [DI] ;LETTER的个数放到寄存器AX
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
	
	MOV DL, 0DH
	MOV AH, 02H
	INT 21H
	MOV DL, 0AH
	INT 21H
	
	LEA DX,STR3
    MOV AH, 09H
    INT 21H
	LEA DI, LENGTH
	MOV AH, 0
	MOV AL, [DI] ;字符串的个数放到寄存器AX
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
	MOV AH,4CH
	INT 21H
CODE ENDS
	END START