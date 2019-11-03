;;找关键数据的地址
DATA SEGMENT
    LINTAB DW 30,-48,0,100,-9,38,128,-250,-80,-100
    COUNT  DW 10
    KEYBUF DW 0
    ADDR   DW -1    ;我的教材是找不到-1存到ADDR单元
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    LEA SI, LINTAB
    LEA DI, COUNT
    MOV CX, [DI]
    LEA DI, KEYBUF
NEXT:
    MOV AX, [SI]
    CMP AX, [DI]
    JZ FINISH     ;找到关键数据
    INC SI
    INC SI
    DEC CX
    CMP CX, 0
    JZ NOTFINISH  ;找不到关键数据
    JMP NEXT
NOTFINISH:
    MOV AH, 02H
    MOV DL, 'N'
    INT 21H
    JMP EXIT
FINISH:
    MOV AX, SI
    MOV [ADDR], AX
    MOV AH, 02H
    MOV DL, 'Y'
    INT 21H
EXIT:
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START