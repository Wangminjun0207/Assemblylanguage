;设置8255的A口为输出方式，B口为输入方式
;实现与B口相连的开关状态到A口相连的LED的数据传输
;拨动开关，LED的状态立即发生改变
IOYO        EQU 0600H
MY8255_A    EQU IOYO+00H*2
MY8255_B    EQU IOYO+01H*2
MY8255_C    EQU IOYO+02H*2
MY8255_MODE EQU IOYO+03H*2
CODE SEGMENT
	ASSUME CS:CODE
START:
	MOV DX, MY8255_MODE  
	MOV AL, 82H
	OUT DX, AL
AA1:
	MOV DX,MY8255_B
	IN AL, DX
	CALL DELAY
	MOV DX, MY8255_A
	OUT DX, AL
	JMP AA1
DELAY:
	PUSH CX
	MOV CX, 0F00H
AA2:
	PUSH AX
	POP AX
	LOOP AA2
	POP CX
	RET
CODE ENDS
	END START                                                                                                   