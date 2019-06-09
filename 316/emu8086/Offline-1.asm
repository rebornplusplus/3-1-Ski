; UVa 100 - The 3n+1 Problem
; 
; Rafid Bin Mostofa
; 1605109
; Jun 10 2019 0253

.MODEL SMALL
.STACK 100H

.DATA
    TEMP DW ?
    VAL_A DW ?
    VAL_B DW ?
    MAX DW ?
    N DW ?
    CNT DW ?
    I DW ?
    
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        ; PRINTS "A="
        MOV AH, 2
        MOV DL, 65
        INT 21H
        MOV DL, 61
        INT 21H
        
        ; INITIALIZE BY ZERO
        MOV VAL_A, 0
        
        ; THIS LOOP INPUTS THE VALUE OF A
        INP_DEC_A:
            MOV AH, 1
            INT 21H
            
            CMP AL, 13
            JE END_INP_A
            
            MOV AH, 0
            MOV TEMP, AX
            SUB TEMP, 48
            
            MOV AX, VAL_A
            MOV BX, 10
            MUL BX
            ADD AX, TEMP
            MOV VAL_A, AX
            
            JMP INP_DEC_A
        
        END_INP_A:
        
        ; PRINTS NEW LINE
        MOV AH, 2
        MOV DL, 10
        INT 21H
        
        ; PRINTS "B="
        MOV AH, 2
        MOV DL, 66
        INT 21H
        MOV DL, 61
        INT 21H
        
        ; INITIALIZE BY ZERO
        MOV VAL_B, 0
        
        ; THIS LOOP INPUTS THE VALUE OF VAL_B
        INP_DEC_B:
            MOV AH, 1
            INT 21H
            
            CMP AL, 13
            JE END_INP_B
            
            MOV AH, 0
            MOV TEMP, AX
            SUB TEMP, 48
            
            MOV AX, VAL_B
            MOV BX, 10
            MUL BX
            ADD AX, TEMP
            MOV VAL_B, AX
            
            JMP INP_DEC_B
        
        END_INP_B:
        
        ; JUST FOR TESTING
        MOV BX, VAL_A
        MOV CX, VAL_B
        
        ; SWAP A, B IF A > B
        CMP BX, CX
        JLE SWAP_DONE
        
        MOV VAL_A, CX
        MOV VAL_B, BX
        
        SWAP_DONE:
        
        ; JUST FOR TESTING
        MOV BX, VAL_A
        MOV CX, VAL_B 
        
        ; BEGINNING OF THE PROBLEM!
        MOV MAX, 0
        
        ; FOR I=A; I<=B; ++I
        MOV AX, VAL_A
        MOV I, AX
        
        ITER_A2B:
            MOV AX, I
            CMP AX, VAL_B
            JG DONE_ITER_A2B
        
            ; LIL' PROB
            MOV AX, I
            MOV N, AX
            MOV CNT, 0
            
            ITER_TILL_1:
                MOV AX, N
                CMP AX, 1
                JE DONE_ITER_TILL_1
                
                MOV DX, 0
                MOV AX, N
                MOV CX, 2
                DIV CX
                
                CMP DX, 0
                JE EVEN
                
                ODD:
                    MOV AX, N
                    MOV CX, 3
                    MUL CX
                    ADD AX, 1
                    MOV CX, 2
                    DIV CX
                    MOV N, AX
                    ADD CNT, 2
                    JMP IF_ELSE_DONE
                EVEN:
                    MOV AX, N
                    MOV CX, 2
                    DIV CX
                    MOV N, AX
                    ADD CNT, 1
                    ; JMP IF_ELSE_DONE
                IF_ELSE_DONE:
                
                JMP ITER_TILL_1
            
            DONE_ITER_TILL_1:
            
            ADD CNT, 1
            MOV CX, CNT
            
            CMP CX, MAX
            JLE DONE_SETTING_MAX
            
            MOV MAX, CX
            
            DONE_SETTING_MAX:
            
            ADD I, 1
            JMP ITER_A2B
        
        DONE_ITER_A2B:
        ; PROBLEM SOLVED
        
        MOV CX, MAX
        
        ; RETURN 0
        MOV AH, 4CH
        INT 21H
    MAIN ENDP
END MAIN
