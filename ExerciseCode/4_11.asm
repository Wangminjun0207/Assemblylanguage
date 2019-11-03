DATA SEGMENT
    STRING DB 'It is FEB&03'
    COUNT = $-STRING ;字符串长度
DATA ENDS
CODE SEGMENT 
    ASSUME DS:DATA, CS:CODE
START:
    MOV AX, DATA
    MOV DS, AX
    LEA SI, STRING
    MOV CX, COUNT
AGAIN:
    MOV AL, [SI]
    CMP AL, '&'
    JNZ NEXT
    MOV AL, ' ' ;用空格替换&
    MOV [SI], AL
NEXT:
    INC SI
    LOOP AGAIN
EXIT:
    MOV DX, OFFSET STRING 
    MOV STRING+COUNT, '$';在最后添加$ 
                         ;为了输出替换后的字符串
    MOV AH, 9
    INT 21H  ;输出替换后的字符串
    MOV AH, 4CH
    INT 21H
CODE ENDS
    END START