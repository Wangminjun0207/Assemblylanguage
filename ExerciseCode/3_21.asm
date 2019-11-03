;3_21
;比较两个字符串是否完全相同
;相同显示match,不相同显示NOT MATCH
DATA SEGMENT
    BUF1 DB 100
         DB 0
         DB 100 DUP(0)
    BUF2 DB 100
         DB 0
         DB 100 DUP(0)
    ;提示性的字符串
    STR1 DB 'MATCH$'
    STR2 DB 'NOT MATCH$'
    STR3 DB 'PLEASE INPUT FIRST STRING:$'
    STR4 DB 'PLEASE INPUT SECOND STRING:$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    
    ;输入第一个字符串
    MOV DX, OFFSET STR3
    MOV AH, 09H
    INT 21H
    MOV DX, OFFSET BUF1
    MOV AH, 0AH
    INT 21H
    ;下面6行代码是回车换行
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    ;输入第二个字符串
    MOV DX, OFFSET STR4
    MOV AH, 09H
    INT 21H
    MOV DX, OFFSET BUF2
    MOV AH, 0AH
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H 
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H 
    
    ;判断两个字符串长度是否相同
    MOV SI, OFFSET BUF1
    INC SI
    MOV DI, OFFSET BUF2
    INC DI
    MOV AL, [SI]
    MOV AH, [DI]
    CMP AL, AH
    ;长度不相同，肯定不匹配，跳转
    JNZ NMATCH
    MOV CX, 100
NEXT:
    INC SI
    INC DI
    MOV AL, [SI]
    MOV AH, [DI]
    CMP AL, AH
    JNZ NMATCH
    LOOP NEXT
MATCH:
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H
    JMP EXIT
NMATCH:
    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H
EXIT:
    MOV AH,4CH
    INT 21H
CODE ENDS
    END START

