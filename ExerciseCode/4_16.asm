;����ʮ��ѧ���ɼ�ͳ��60-69 70-79 80-89 90-99 100������
DATA SEGMENT 
    S6  DB 0   ;������60-69֮�������
    S7  DB 0   ;������70-79֮�������
    S8  DB 0   ;������80-89֮�������
    S9  DB 0   ;������90-99֮�������
    S10 DB 0   ;����Ϊ100������
    GD  DB 40,0,40 DUP(' ') ;�ַ����ɼ����ݿ�
    CJ  DB 10 DUP(0)        ;ת����ĳɼ����ݿ�  
    ;;;;;;��ʾ���ַ����ױ���
    STR1 DB 'PLEASE INPUT TEN NUMBERS:$'
    STR2 DB '60-69: $'
    STR3 DB '70-79: $'
    STR4 DB '80-89: $'
    STR5 DB '90-99: $'
    STR6 DB '100  : $' 
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX                                       
    LEA DX, STR1
    MOV AH, 09H
    INT 21H
    LEA DX, GD   ;��ȡ�ɼ����ݿ��ƫ�Ƶ�ַ��DX�Ĵ���
    MOV AH, 0AH  ;ϵͳ���ã������ַ���
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    LEA DI, CJ
    LEA SI, GD+42;ָ�����һ����Ч�ַ� 
    MOV DH, 0    ;DH���� �ɼ���λ
    MOV DL, 0    ;DL���� �ɼ�ʮλ         
    MOV BH, 0    ;BH���� �ɼ���λ
    MOV CX, 10   ;������
       
SPACE:           ;ȥ������ո�  
    DEC SI
    MOV BL, [SI]
    CMP BL, ' '    
    JZ  SPACE      ; ÿ�����ɼ��ո����  
    
AGAIN:
    DEC SI
    MOV BL, [SI]
    CMP BL, ' '
    JZ NEXT      ; ÿ�����ɼ��ո����
    SUB BL, 30H  ; �ַ�ת������ֵ 
    MOV BH, BL
    
    DEC SI
    MOV BL, [SI]
    CMP BL, ' '
    JZ NEXT      ; ÿ�����ɼ��ո����
    SUB BL, 30H  ; �ַ�ת������ֵ 
    MOV DL, BL
    
    DEC SI 
    MOV BL, [SI]
    CMP BL, ' '
    JZ NEXT      ; ÿ�����ɼ��ո����
    SUB BL, 30H  ; �ַ�ת������ֵ 
    MOV DH, BL
NEXT:     
    MOV AL, DH 
    MOV AH, 100
    MUL AH
    MOV DH, AL 
    
    MOV AL, DL
    MOV AH, 10
    MUL AH
    
    ADD AL, BH
    ADD AL, DH  ;���ĳɼ���AL�Ĵ��� 
     
    MOV [DI], AL
    INC DI
    MOV DH, 0    ;DH����
    MOV DL, 0    ;DL����       
    MOV BH, 0    ;BH���� 
    LOOP AGAIN
TJ:
    LEA DI, CJ
    MOV BH, 10
TJ1:
    MOV AL, [DI]
    CMP AL, 100
    JZ ADDS10
    CMP AL, 90
    JAE ADDS9
    CMP AL, 80
    JAE ADDS8
    CMP AL, 70
    JAE ADDS7
    CMP AL, 60
    JAE ADDS6
ADDS10: 
    INC S10
    JMP TJNEXT
ADDS9: 
    INC S9  
    JMP TJNEXT
ADDS8:    
    INC S8  
    JMP TJNEXT
ADDS7:    
    INC S7 
    JMP TJNEXT
ADDS6:    
    INC S6
    JMP TJNEXT
TJNEXT:
    INC DI
    DEC BH
    CMP BH, 0
    JNZ TJ1

PREPRINT: 
    LEA SI, S6
    MOV CX, 5
    LEA DI, STR2
PRINT:
    LEA DX, [DI]
    MOV AH, 09H
    INT 21H     
    MOV DL, [SI]
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    INC SI
    DEC CX
    CMP CX, 4 
    JZ TOSTR3
    CMP CX, 3
    JZ TOSTR4
    CMP CX, 2
    JZ TOSTR5
    CMP CX, 1
    JZ TOSTR6
    JMP EXIT 
TOSTR3:
    LEA DI, STR3       
    JZ PRINT
TOSTR4:
    LEA DI, STR4         
    JZ PRINT
TOSTR5:          
    LEA DI, STR5
    JZ PRINT
TOSTR6:           
    LEA DI, STR6
    JZ PRINT
EXIT:
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START      