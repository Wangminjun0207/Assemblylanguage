SUB3 PROC  
    PUSH BX  
    MOV BX,0  
    LEA  DI,ASCNUM  
    CMP  AX,0  
    JNS  CHG  
    NEG  AX  
    MOV BYTE PTR [DI],'-'  
    JMP  NEXT 
CHG:  
    MOV BYTE PTR [DI],'+' 
NEXT:
    MOV DX,0 
    MOV CX,10000  
    DIV  CX ;��λ������ AX ��  
    CMP  AL,0  
    JZ  N1  
    MOV BX,5  
    OR  AL,30H  
    INC  DI  
    MOV [DI],AL ;����λ 
N1:  
    MOV AX,DX  
    MOV DX,0  
    MOV CX,1000  
    DIV  CX  
    CMP  BX,0  
    JNZ  N2  
    CMP  AL,0  
    JZ  N3  
    MOV BX,4 
N2:  
    OR  AL,30H  
    INC  DI  
    MOV [DI],AL ;��ǧ 
N3:  
    MOV AX,DX 
    MOV CL,100  
    DIV  CL  
    CMP  BX,0  
    JNZ  N4  
    CMP  AL,0  
    JZ  N5  
    MOV BX,3 
N4:  
    OR  AL,30H  
    INC  DI  
    MOV [DI],AL ;���λ 
N5:  
    MOV AL,AH  
    MOV AH,0  
    MOV CL,10  
    DIV  CL  
    CMP  BX,0  
    JNZ  N6  
    CMP  AL,0  
    JZ  N7  
    MOV BX,2 
N6:  
    OR  AL,30H  
    INC  DI  
    MOV [DI],AL ;��ʮλ 
N7:  
    OR  AH,30H  
    INC  DI 
     MOV [DI],AH  
     CMP  BX,0  
     JNZ  SN
      MOV BX,1 
SN:  
    MOV CX,BX ; ����λ����  
    INC  CX ;����=��λ+1 λ����λ  
    LEA  DX,ASCNUM  POP  BX  RET 
SUB3 ENDP 