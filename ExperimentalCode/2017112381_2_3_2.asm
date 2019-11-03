;按下键盘按键后，按键编码从左向右依次显示在6个数码管上，循环显示

IOY0         EQU  0600H
MY8255_A     EQU  IOY0+00H*2
MY8255_B     EQU  IOY0+01H*2
MY8255_C     EQU  IOY0+02H*2
MY8255_CON   EQU  IOY0+03H*2

SSTACK SEGMENT STACK
       DW 16 DUP(?)
SSTACK ENDS

DATA   SEGMENT
DTABLE DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H
       DB 7FH,6FH,77H,7CH,39H,5EH,79H,71H
DATA   ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA
       
START: MOV AX,DATA
       MOV DS,AX
       MOV SI,3000H
       MOV AL,00H
       MOV [SI],AL
       MOV [SI+1],AL
       MOV [SI+2],AL
       MOV [SI+3],AL
       MOV [SI+4],AL
       MOV [SI+5],AL
       MOV DI,3005H
       MOV DX,MY8255_CON
       MOV AL,81H
       OUT DX,AL

BEGIN: CALL DIS
       CALL CLEAR
       CALL CCSCAN
       JNZ INK1 
       JMP BEGIN

INK1:  CALL DIS
       CALL DALLY
       CALL DALLY
       CALL CLEAR
       CALL CCSCAN
       JNZ INK2
       JMP BEGIN
       
INK2:  MOV CH,0FEH
       MOV CL,00H
       
COLUM: MOV AL,CH
       MOV DX,MY8255_A
       OUT DX,AL
       MOV DX,MY8255_C
       IN AL,DX

L1:    TEST AL,01H
       JNZ L2
       MOV AL,00H
       JMP KCODE
       
       
L2:    TEST AL,02H
       JNZ L3
       MOV AL,04H
       JMP KCODE

L3:    TEST AL,04H
       JNZ L4
       MOV AL,08H
       JMP KCODE

L4:    TEST AL,08H
       JNZ NEXT
       MOV AL,0CH

KCODE: ADD AL,CL
       CALL PUTBUF
       PUSH AX
       
KON:   CALL DIS
       CALL CLEAR
       CALL CCSCAN
       JNZ KON
       POP AX
       
NEXT:  INC CL
       MOV AL,CH
       TEST AL,08H
       JZ KERR
       ROL AL,1
       MOV CH,AL
       JMP COLUM
       
KERR:  JMP BEGIN

CCSCAN:MOV AL,00H
       MOV DX,MY8255_A
       OUT DX,AL
       MOV DX,MY8255_C
       IN AL,DX
       NOT AL
       AND AL,0FH
       RET
       
CLEAR: MOV DX,MY8255_B
       MOV AL,00H
       OUT DX,AL
       RET
       
DIS:   PUSH AX
       MOV SI,3000H
       MOV DL,0FEH
       MOV AL,DL
AGAIN:
	PUSH DX
	MOV DX,MY8255_A
	OUT DX, AL
	MOV AL, [SI]
	MOV BX,OFFSET DTABLE
	AND AX, 00FFH
	ADD BX,AX
	MOV AL,[BX]
	MOV DX,MY8255_B
	OUT DX,AL
	CALL DALLY
	INC SI
	POP DX
	MOV AL,DL
	TEST AL,40H
	JZ OUT1
	ROL AL,1
	MOV DL,AL
	JMP AGAIN
OUT1:
	POP AX
	RET
       
DALLY: PUSH CX
       MOV CX,0006H

T1:    MOV AX,009FH

T2:    DEC AX
       JNZ T2
       LOOP T1
       POP CX
       RET
       
PUTBUF:
	   MOV SI,DI
       MOV [SI],AL
       DEC DI
       CMP DI,2FFFH
       JNZ GOBACK
       MOV DI,3005H
GOBACK:
	   RET       

CODE   ENDS
       END START
                                                                                                         