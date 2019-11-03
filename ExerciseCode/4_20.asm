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
	MOV AH, 0AH ;�ַ�������dos
	INT 21H
	MOV DL, 0DH
	MOV AH, 02H
	INT 21H
	MOV DL, 0AH
	INT 21H
	LEA SI, STRING+1
	MOV AL, [ SI]    ;�ַ������ȷŵ�LENGTH��Ԫ
	MOV LENGTH, AL
	LEA SI, STRING+2
	MOV AH, 0DH
NEXT:
	MOV AL,[SI]
	CMP AL, AH      ;�Ƚ��Ƿ��ǻس��ַ�
	JZ PRINT	
	CMP AL,30H      ;�Ƚ��Ƿ��������ַ�
	JB JNEXT
	CMP AL,39H
	JBE TODIGITAL
	CMP AL,41H      ;�Ƚ��Ƿ�����ĸ�ַ�
	JB JNEXT
	CMP AL,5AH
	JBE TOLETTER
	CMP AL,61H      ;�Ƚ��Ƿ�����ĸ�ַ�
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
	MOV AL, [DI] ;digital�ĸ����ŵ��Ĵ���AX
	MOV DL, 10   ;�����ŵ��Ĵ���DL
	DIV DL
	MOV DL, AL   ;������ʮλ
	ADD DL, 30H
	MOV DH, AH   ;�����ĸ�λ
	MOV AH, 02H  ;ʮλ���
	INT 21H
	ADD DH, 30H
	MOV DL, DH   ;��λ���
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
	MOV AL, [DI] ;LETTER�ĸ����ŵ��Ĵ���AX
	MOV DL, 10   ;�����ŵ��Ĵ���DL
	DIV DL
	MOV DL, AL   ;������ʮλ
	ADD DL, 30H
	MOV DH, AH   ;�����ĸ�λ
	MOV AH, 02H  ;ʮλ���
	INT 21H
	ADD DH, 30H
	MOV DL, DH   ;��λ���
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
	MOV AL, [DI] ;�ַ����ĸ����ŵ��Ĵ���AX
	MOV DL, 10   ;�����ŵ��Ĵ���DL
	DIV DL
	MOV DL, AL   ;������ʮλ
	ADD DL, 30H
	MOV DH, AH   ;�����ĸ�λ
	MOV AH, 02H  ;ʮλ���
	INT 21H
	ADD DH, 30H
	MOV DL, DH   ;��λ���
	MOV AH, 02H
	INT 21H
EXIT:
	MOV AH,4CH
	INT 21H
CODE ENDS
	END START