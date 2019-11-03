;输入十个学生成绩统计60-69 70-79 80-89 90-99 100的人数
DATA SEGMENT 
    S6  DB 0   ;分数在60-69之间的人数
    S7  DB 0   ;分数在70-79之间的人数
    S8  DB 0   ;分数在80-89之间的人数
    S9  DB 0   ;分数在90-99之间的人数
    S10 DB 0   ;分数为100的人数
    GD  DB 40,0,40 DUP(' ') ;字符串成绩数据块
    CJ  DB 10 DUP(0)        ;转换后的成绩数据块  
    ;;;;;;提示性字符串白变量
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
    LEA DX, GD   ;获取成绩数据块的偏移地址给DX寄存器
    MOV AH, 0AH  ;系统调用，输入字符串
    INT 21H
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    LEA DI, CJ
    LEA SI, GD+42;指到最后一个有效字符 
    MOV DH, 0    ;DH清零 成绩百位
    MOV DL, 0    ;DL清零 成绩十位         
    MOV BH, 0    ;BH清零 成绩个位
    MOV CX, 10   ;计数器
       
SPACE:           ;去除多余空格  
    DEC SI
    MOV BL, [SI]
    CMP BL, ' '    
    JZ  SPACE      ; 每两个成绩空格隔开  
    
AGAIN:
    DEC SI
    MOV BL, [SI]
    CMP BL, ' '
    JZ NEXT      ; 每两个成绩空格隔开
    SUB BL, 30H  ; 字符转换成数值 
    MOV BH, BL
    
    DEC SI
    MOV BL, [SI]
    CMP BL, ' '
    JZ NEXT      ; 每两个成绩空格隔开
    SUB BL, 30H  ; 字符转换成数值 
    MOV DL, BL
    
    DEC SI 
    MOV BL, [SI]
    CMP BL, ' '
    JZ NEXT      ; 每两个成绩空格隔开
    SUB BL, 30H  ; 字符转换成数值 
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
    ADD AL, DH  ;最后的成绩在AL寄存器 
     
    MOV [DI], AL
    INC DI
    MOV DH, 0    ;DH清零
    MOV DL, 0    ;DL清零       
    MOV BH, 0    ;BH清零 
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