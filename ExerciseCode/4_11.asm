DATA SEGMENT
    STRING DB 'It is FEB&03'
    COUNT = $-STRING ;�ַ�������
DATA ENDS
CODE SEGMENT 
    ASSUME DS:DATA, CS:CODE
START:
    MOV AX, DATA
    MOV DS, AX
    LEA SI, STRING
    MOV CX, COUNT
AGAIN:
    MOV AL, [SI]
    CMP AL, '&'
    JNZ NEXT
    MOV AL, ' ' ;�ÿո��滻&
    MOV [SI], AL
NEXT:
    INC SI
    LOOP AGAIN
EXIT:
    MOV DX, OFFSET STRING 
    MOV STRING+COUNT, '$';��������$ 
                         ;Ϊ������滻����ַ���
    MOV AH, 9
    INT 21H  ;����滻����ַ���
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START