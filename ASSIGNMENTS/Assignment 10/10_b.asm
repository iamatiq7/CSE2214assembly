.MODEL SMALL
.STACK 100H 

.DATA
INPUT_MSG DB "ENTER A LINE OF TEXT: $"
CAPITAL_KEY DB 65 DUP(' '), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
ANS DB 100 DUP('$')
NEWLINE DB 0DH,0AH,'$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA BX,CAPITAL_KEY
    LEA DI, ANS
    
    MOV AH,9
    LEA DX,INPUT_MSG
    INT 21H   
    
    
    INPUT:
    MOV AH,1
    INT 21H
    
    CMP AL,0DH
    JE PRINT
    
    CMP AL,60H
    JLE NOT_DECODE
    CMP AL,7BH
    JGE NOT_DECODE
    
    SUB AL,20H
    XLAT
    
    NOT_DECODE:
    MOV [DI],AL
    INC DI
    JMP INPUT
    
   
    PRINT:
    ;GOTO NEW LINE
    MOV AH,9
    LEA DX,NEWLINE
    INT 21H
    
    LEA DX,ANS
    INT 21H
    
    
    EXIT:
    MOV AH,4CH
    INT 21H
    END MAIN