;数据段10H单元×10放到12H,不使用乘法
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
    MOV AL, [SI] ;将元数据取到AL中 
    SAL AL,1     ;AL左移一位，变为2X 
    MOV BL, AL   ;2X送到BL
    MOV CL,2  
    SAL BL,CL    ;将BL右移两次变为8X
    ADD AL,BL    ;AL+BL为10X 
    LEA SI, DAT1 ;将结果写到DTA1单元
    MOV [SI],AL 
EXIT:   
    MOV AH,4CH  
    INT  21H 
CODE ENDS  
    END START