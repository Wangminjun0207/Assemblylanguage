;;���ַ����ո���
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
    LEA DX, STRING ;�����ַ���
    MOV AH, 0AH
    INT 21H
    
    MOV DL, 0DH
	MOV AH, 02H
	INT 21H
	MOV DL, 0AH 
	MOV AH, 02H
	INT 21H
    MOV AH, 0DH    ;�س�ASCII��
    LEA SI, STRING+2 ;SIָ����һ����Ч�ַ�
NEXT:
    MOV AL, [SI]  
    INC SI
    CMP AL, AH    ;�ж��Ƿ����ַ�����β
    JZ PRINT
    CMP AL, ' '   ;�ж��Ƿ��ǿո�
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
	MOV AL, [DI] ;�ո�ĸ����ŵ��Ĵ���AL
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
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START