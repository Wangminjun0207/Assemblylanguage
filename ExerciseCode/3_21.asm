;3_21
;�Ƚ������ַ����Ƿ���ȫ��ͬ
;��ͬ��ʾmatch,����ͬ��ʾNOT MATCH
DATA SEGMENT
    BUF1 DB 100
         DB 0
         DB 100 DUP(0)
    BUF2 DB 100
         DB 0
         DB 100 DUP(0)
    ;��ʾ�Ե��ַ���
    STR1 DB 'MATCH$'
    STR2 DB 'NOT MATCH$'
    STR3 DB 'PLEASE INPUT FIRST STRING:$'
    STR4 DB 'PLEASE INPUT SECOND STRING:$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    
    ;�����һ���ַ���
    MOV DX, OFFSET STR3
    MOV AH, 09H
    INT 21H
    MOV DX, OFFSET BUF1
    MOV AH, 0AH
    INT 21H
    ;����6�д����ǻس�����
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    ;����ڶ����ַ���
    MOV DX, OFFSET STR4
    MOV AH, 09H
    INT 21H
    MOV DX, OFFSET BUF2
    MOV AH, 0AH
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H 
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H 
    
    ;�ж������ַ��������Ƿ���ͬ
    MOV SI, OFFSET BUF1
    INC SI
    MOV DI, OFFSET BUF2
    INC DI
    MOV AL, [SI]
    MOV AH, [DI]
    CMP AL, AH
    ;���Ȳ���ͬ���϶���ƥ�䣬��ת
    JNZ NMATCH
    MOV CX, 100
NEXT:
    INC SI
    INC DI
    MOV AL, [SI]
    MOV AH, [DI]
    CMP AL, AH
    JNZ NMATCH
    LOOP NEXT
MATCH:
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H
    JMP EXIT
NMATCH:
    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H
EXIT:
    MOV AH,4CH
    INT 21H
CODE ENDS
    END START

