;3-20
;��1000H��Ԫ��ʼ��1000�����ֽڴ�������
;�ҳ�������С�ķŵ�2000H��Ԫ 
;DATA SEGMENT
;    ORG 1000H
;    DAT DB 100 DUP(12H,-128,100,0,56H,4,128,200,44H,123)
;    ORG 2000H 
;    MINVAL DB 0 
;DATA ENDS 
CODE SEGMENT
    ASSUME CS:CODE;,DS:DATA
START: 
    ;MOV AX, DATA
    ;MOV DS, AX
    MOV CX, 1000  ;��ʼ��������
    ;LEA SI, DAT   ;��ʼ�����ݶα�ַ�Ĵ���
    MOV SI, 1000H 
    MOV AL, [SI] 
    DEC CX
COMPARE: 
    INC SI
    CMP AL, [SI]
    JLE ISMIN     ;û�ҵ���С����ʱ��ת
    MOV AL, [SI]  ;����С�����浽AL�� 
ISMIN:
    DEC CX
    CMP CX, 0
    JNZ COMPARE
    MOV SI, 2000H 
    MOV [SI], AL ;����Сֵ�ŵ�2000H��Ԫ
EXIT:       
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START
    