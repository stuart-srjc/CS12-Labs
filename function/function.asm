; Data
section     .data
extern  printMSG
extern  printEndl
extern  printReg
extern  printRAX
extern  exitNormal
extern  getRand

extern  mulby4
extern  printXtimes  
extern  getRandNum
extern  getMax

; Code 
section     .text


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


global _start
_start:
;-----------------------------------------------------------------------------------
; print header 
;-----------------------------------------------------------------------------------
    mov rdi, 0xd    ; set rdi to point to the CS12 Array
    call printMSG   ; printMSG takes rdi as its parameter as shown in the list below
    
    mov rdi, 0x0    ; set rdi to point to the 0x0A Array (carriage return)
    call printMSG   ; printMSG takes rdi as its parameter as shown in the list below
;-----------------------------------------------------------------------------------


;-----------------------------------------------------------------------------------
; test mulby4 first with 4
    mov     rdi,    0x4    
    call    mulby4  
    call    printRAX    
    
; test mulby4 then with 16 (0x10) 
    mov     rdi,    0x10    
    call    mulby4  
    call    printRAX    
        
    call    printEndl
;-----------------------------------------------------------------------------------
    

;-----------------------------------------------------------------------------------
; test  printXtimes with 4 three times
    mov rdi, 0x4
    mov rsi, 0x3    
    call    printXtimes 
    call    printEndl
    
; test  printXtimes with 3 four times
    mov rdi, 0x3
    mov rsi, 0x4    
    call    printXtimes 
    call    printEndl
    
;-----------------------------------------------------------------------------------
    

;-----------------------------------------------------------------------------------
; test getRand
    
    mov  rdi, 0x10
    call getRandNum
    call printRAX
    
    mov  rdi, 0x10
    call getRandNum
    call printRAX
    
    mov  rdi, 0x10
    call getRandNum
    call printRAX
    call    printEndl

;-----------------------------------------------------------------------------------
; test getMax
    mov rdi,    0x100
    mov rsi,    0x100
    mov rdx,    0x103
    mov rcx,    0x100
    mov r8,     0x100
    mov r9,     0x100
    call    getMax 
    call    printRAX
    call    printEndl

    call    exitNormal
