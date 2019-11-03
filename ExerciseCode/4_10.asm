DATA SEGMENT
    STR DB 'HELLO$'   ;定义字符串
DATA ENDS

CODE SEGMENT
    ASSUME DS:DATA, CS:CODE    
START:
    MOV AX, DATA
    MOV DS, AX
    LEA SI, STR     ;初始化原变址寄存器
    MOV CX, 0       ;计数器清零
AGAIN:
    MOV AL, [SI]
    CMP AL, '$'     ;判断字符串是否到结尾
    JZ NEXT         ;到结尾跳转到NEXT代码段
    INC CX
    INC SI          ;下一存储单元
    JMP AGAIN       ;继续计数
NEXT:
    MOV DX, CX
MOVDATA:
    MOV [SI+2], AL
    DEC SI
    MOV AL, [SI]
    LOOP MOVDATA
    MOV [SI]+2, AL  ;最后一次取到寄存器的字符存入内存
    MOV WORD PTR [SI] ,DX ;字符个数放到STR单元，且占两个字节
EXIT:
    OR DX, 30H
    MOV AX, DX
    MOV AH, 02H
    INT 21H         ;输出字符串长度
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START
    