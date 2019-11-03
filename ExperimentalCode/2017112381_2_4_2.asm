;实现通过8255的B口控制步进电机逆时针旋转
IOY0         EQU  0600H
MY8255_A     EQU  IOY0+00H*2
MY8255_B     EQU  IOY0+01H*2
MY8255_C     EQU  IOY0+02H*2
MY8255_MODE  EQU  IOY0+03H*2

SSTACK SEGMENT STACK
       DW 256 DUP(?)
SSTACK ENDS

DATA   SEGMENT
TABDT  DB 09H,08H,0CH,04H,06H,02H,03H,01H
DATA   ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA
       
START: MOV AX,DATA
       MOV DS,AX
   
MAIN:  MOV AL,90H
       MOV DX,MY8255_MODE
       OUT DX,AL
       
A1:    MOV BX,OFFSET TABDT
       MOV CX,0008H
       
A2:    MOV AL,[BX]
       MOV DX,MY8255_B
       OUT DX,AL
       CALL DALLY
       INC BX
       LOOP A2
       JMP A1
      
DALLY: PUSH CX
       MOV CX,8000H
       
A3:    PUSH AX
       POP AX
       LOOP A3
       POP CX
       RET
       
CODE   ENDS
       END START
       