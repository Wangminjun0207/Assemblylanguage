;���ݶ�10H��Ԫ��10�ŵ�12H,��ʹ�ó˷�
DSEG SEGMENT  
    ORG 10H    
    DAT   DB 10    
    DAT1  DB 0 
DSEG ENDS 
CODE SEGMENT  
    ASSUME CS:CODE,DS:DSEG 
START:   
    MOV AX,DSEG  
    MOV DS,AX   
    LEA SI,DAT
    MOV AL, [SI] ;��Ԫ����ȡ��AL�� 
    SAL AL,1     ;AL����һλ����Ϊ2X 
    MOV BL, AL   ;2X�͵�BL
    MOV CL,2  
    SAL BL,CL    ;��BL�������α�Ϊ8X
    ADD AL,BL    ;AL+BLΪ10X 
    LEA SI, DAT1 ;�����д��DTA1��Ԫ
    MOV [SI],AL 
EXIT:   
    MOV AH,4CH  
    INT  21H 
CODE ENDS  
    END START