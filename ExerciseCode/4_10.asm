DATA SEGMENT
    STR DB 'HELLO$'   ;�����ַ���
DATA ENDS

CODE SEGMENT
    ASSUME DS:DATA, CS:CODE    
START:
    MOV AX, DATA
    MOV DS, AX
    LEA SI, STR     ;��ʼ��ԭ��ַ�Ĵ���
    MOV CX, 0       ;����������
AGAIN:
    MOV AL, [SI]
    CMP AL, '$'     ;�ж��ַ����Ƿ񵽽�β
    JZ NEXT         ;����β��ת��NEXT�����
    INC CX
    INC SI          ;��һ�洢��Ԫ
    JMP AGAIN       ;��������
NEXT:
    MOV DX, CX
MOVDATA:
    MOV [SI+2], AL
    DEC SI
    MOV AL, [SI]
    LOOP MOVDATA
    MOV [SI]+2, AL  ;���һ��ȡ���Ĵ������ַ������ڴ�
    MOV WORD PTR [SI] ,DX ;�ַ������ŵ�STR��Ԫ����ռ�����ֽ�
EXIT:
    OR DX, 30H
    MOV AX, DX
    MOV AH, 02H
    INT 21H         ;����ַ�������
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START
    