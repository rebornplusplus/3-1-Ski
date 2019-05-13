; Take two non negative integers n, m
; Calculate whether n x m is odd or even
; n, m < 100
; both integers will be padded with 0s
; so that each of them are of length 2
;
; m=10,n=03
; result should be "EVEN"
;
; Rafid Bin Mostofa
; May 13 2019 2015

.MODEL SMALL
.STACK 100H

.DATA
    A DB 0
    B DB 0
    
    C DB 0
    D DB 0
    
.CODE

    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        
        ; PRINT "m="
        MOV AH, 2
        MOV DL, 109
        INT 21H
        MOV DL, 61
        INT 21H
        
        ; INPUT M ; M = A*10 + B
        MOV AH, 1
        INT 21H
        
        MOV A, AL
        
        INT 21H
        MOV B, AL
        
        ; PRINT NEW LINE
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        ; PRINT "n="
        MOV AH, 2
        MOV DL, 110
        INT 21H
        MOV DL, 61
        INT 21H
        
        ; INPUT N ; N = C*10 + D
        MOV AH, 1
        INT 21H
        
        MOV C, AL
        
        INT 21H
        MOV D, AL
        
        ; PRINT NEW LINE
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        ; PRINT M
        ; MOV AH, 2
        ; MOV DL, A
        ; INT 21H
        ; MOV DL, B
        ; INT 21H
        
        ; PRINT NEW LINE
        ; MOV AH, 2
        ; MOV DL, 10
        ; INT 21H
        ; MOV DL, 13
        ; INT 21H
        
        ; PRINT N
        ; MOV AH, 2
        ; MOV DL, C
        ; INT 21H
        ; MOV DL, D
        ; INT 21H
        
        ; PRINT NEW LINE
        ; MOV AH, 2
        ; MOV DL, 10
        ; INT 21H
        ; MOV DL, 13
        ; INT 21H
        
        SUB A, 48
        SUB B, 48
        SUB C, 48
        SUB D, 48 
        
        ; CHECK EVENNESS OF M
        WHILE_1:
            CMP B, 2
            JB DONE_1
            
            SUB B, 2
            JMP WHILE_1
        DONE_1:
        
        CMP B, 0
        JNE M_ODD
        
        MOV AH, 2
        MOV DL, 69  ; PRINT EVEN HERE
        INT 21H  
        MOV DL, 86
        INT 21H
        MOV DL, 69
        INT 21H
        MOV DL, 78
        INT 21H
        JMP RETURN
        
        M_ODD:
        
        ; CHECK EVENNESS OF N
        WHILE_2:
            CMP D, 2
            JB DONE_2
            
            SUB D, 2
            JMP WHILE_2
        DONE_2:
        
        CMP D, 0
        JNE N_ODD
        
        MOV AH, 2
        MOV DL, 69  ; PRINT EVEN HERE
        INT 21H  
        MOV DL, 86
        INT 21H
        MOV DL, 69
        INT 21H
        MOV DL, 78
        INT 21H
        JMP RETURN
        
        N_ODD:
        
        MOV AH, 2
        MOV DL, 79  ; PRINT ODD HERE
        INT 21H
        MOV DL, 68
        INT 21H
        MOV DL, 68
        INT 21H
        JMP RETURN
        
                   
        RETURN:
        
        MOV AH, 4CH
        INT 21H
    MAIN ENDP
END MAIN
