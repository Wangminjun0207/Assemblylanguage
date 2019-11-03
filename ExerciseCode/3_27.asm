DSEG SEGMENT
  ORG 10H    
  DAT  DB 10H,20H    
       DB 0,0 
DSEG ENDS 
CODE SEGMENT  
    ASSUME CS:CODE,DS:DSEG 
START:   
    MOV AX,DSEG  
    MOV DS,AX
    LEA SI, DAT   
    MOV AL,[SI]
    INC SI  
    MOV AH,[SI]  
    MOV CL,3  
    SAR  AX,CL ;有符号数，算术右移三次（流程图两次有误）
    
    INC SI   
    MOV [SI],AL
    
    INC SI  
    MOV [SI],AH
EXIT:      
    MOV AH,4CH  
    INT  21H 
CODE ENDS
    END START