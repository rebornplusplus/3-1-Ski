.MODEL SMALL
.STACK 100H

.DATA
    I DB ?
    J DB ?
    K DB ?
    N DB ?
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        ; INPUT N
        MOV AH, 1
        INT 21H
        
        ; CHAR TO DECIMAL
        MOV N, AL
        SUB N, 48
        
        ; NEW LINE PRINT
        MOV AH, 2
        MOV DL, 10  ; NEW LINE
        INT 21H
        MOV DL, 13  ; CARRIAGE RETURN
        INT 21H
        
        MOV I, 0
        ROW_SWEEP:
            MOV CL, I
            CMP CL, N
            JE DONE_SWEEP
            
            MOV CL, N
            SUB CL, I
            SUB CL, 1
            MOV K, CL
            
            ADD_SPACES:
                CMP K, 0
                JZ SPACE_DONE
                
                MOV AH, 2
                MOV DL, 32  ; SPACE = 32 IN ASCII
                INT 21H
                
                SUB K, 1
                JMP ADD_SPACES
            
            SPACE_DONE:
            
            ; I'TH ROW WILL HAVE 2*I+1 *S
            MOV CL, 0
            ADD CL, I
            ADD CL, I
            MOV K, CL
            
            MOV J, 0
            COL_SWEEP:
                MOV CL, J
                CMP CL, K
                JA COL_DONE
                
                MOV AH, 2
                MOV DL, 42
                INT 21H
                
                ADD J, 1
                JMP COL_SWEEP
            
            COL_DONE:
            
            MOV AH, 2
            MOV DL, 10  ; NEW LINE
            INT 21H
            MOV DL, 13  ; CARRIAGE RETURNS TO BEGINNING
            INT 21H
            
            ADD I, 1
            JMP ROW_SWEEP
        
        DONE_SWEEP:
        
        ; OUTPUT N
        MOV AH, 2
        MOV DL, N
        ADD DL, 48
        INT 21H
        
        ; RETURN 0
        MOV AH, 4CH
        INT 21H
    MAIN ENDP
END MAIN
