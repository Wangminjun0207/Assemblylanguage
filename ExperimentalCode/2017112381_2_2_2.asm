;设置8255的A口和B口均为输出口，并实现LED灯D7-D0由右向左
;每次仅亮一个灯，循环显示
;D15-D8刚好相反显示
IOYO        EQU 0600H
MY8255_A    EQU IOYO+00H*2
MY8255_B    EQU IOYO+01H*2
MY8255_C    EQU IOYO+02H*2
MY8255_MODE EQU IOYO+03H*2
CODE SEGMENT
	ASSUME CS:CODE
START:
	MOV DX, MY8255_MODE  
	MOV AL, 80H
	OUT DX, AL
	MOV AX,0001H
	PUSH AX
	MOV AX, 0080H
	PUSH AX
AA1:
	MOV DX,MY8255_A
	POP AX
	OUT DX, AL
	ROL AL,1
	MOV BX, AX
	MOV DX,MY8255_B
	POP AX
	OUT DX, AL
	ROR AL,1
	PUSH AX 
	PUSH BX 
	CALL DELAY
	JMP AA1
DELAY:
	MOV CX, 0F000H
AA2:
	LOOP AA2
	RET
CODE ENDS
	END START                                                                                                   