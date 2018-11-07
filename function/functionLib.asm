; Data
section     .data
extern  printMSG
extern  printEndl
extern  printReg
extern  printRAX
extern  exitNormal
extern  getRand

; Code 
section     .text


;-----------------------------------------
; declare functions
global mulby4
global printXtimes  
global getRandNum
global getMax


;-----------------------------------------
; the first 6 parameters are in this order
;-----------------------------------------
;param  64bit   32bit   16bit   8bit
;1      rdi     edi     di      dil
;2      rsi     esi     si      sil
;3      rdx     edx     dx      dl
;4      rcx     ecx     cx      cl
;5      r8      r8d     r8w     r8b
;6      r9      r9d     r8w     r8b
;-----------------------------------------

;-----------------------------------------
; return valuesare in
;       rax     eax     ax      al
;-----------------------------------------


;-----------------------------------------
; the callee must preserve these registers 
;-----------------------------------------
;   rbx rbp r12 r13 r14 r15 
; 
;   The stack must be cleared

;-----------------------------------------------------------------------------------
; mulby4
; description:      multiplies the first parameter by 4
;
; precondition:     rdi has the value to be multiplied by 4
;
; postcondition:    rax has the value of rdi shifted left twice
;                   effectively multiplying by 4       
;
; return            rax has the value of rdi shifted left twice
;-----------------------------------------------------------------------------------
mulby4:
 
;-----------------------------------------------------------------------------------
; printXtimes 
; description:      prints the value in rdi 
;                   the value of rsi times
;
; precondition:     rdi has the value to be displayed
;                   rsi has the number of times to repeat
;
; postcondition:    the value in rdi has been displayed rsi times
;
; return            n/a
;-----------------------------------------------------------------------------------
printXtimes:

;-----------------------------------------------------------------------------------
; getRandNum 
; description:      returns a random number 
;                   between 0 and rdi
;
; precondition:     rdi has the max value to be generated
;
; postcondition:    rax holds a number between 0 and rdi
;           
;
; return            a number between 0 and rdi, in rax
;-----------------------------------------------------------------------------------
getRandNum:

;-----------------------------------------------------------------------------------
; getMax 
; description:      returns a the largest number passed into the function 
;
; precondition:     rdi, rsi, rdx, rcx, r8 and r9 have numbers in them
;
; postcondition:    rax has the largest value passed in above
;           
;
; return            rax has the largest value passed in above
;-----------------------------------------------------------------------------------
getMax:
    

