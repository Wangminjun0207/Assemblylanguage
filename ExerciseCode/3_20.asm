;3-20
;自1000H单元开始有1000个单字节带符号数
;找出其中最小的放到2000H单元 
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
    MOV CX, 1000  ;初始化计数器
    ;LEA SI, DAT   ;初始化数据段变址寄存器
    MOV SI, 1000H 
    MOV AL, [SI] 
    DEC CX
COMPARE: 
    INC SI
    CMP AL, [SI]
    JLE ISMIN     ;没找到更小的数时跳转
    MOV AL, [SI]  ;将更小的数存到AL中 
ISMIN:
    DEC CX
    CMP CX, 0
    JNZ COMPARE
    MOV SI, 2000H 
    MOV [SI], AL ;将最小值放到2000H单元
EXIT:       
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START
    