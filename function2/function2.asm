; Data
section     .data
extern  printMSG
extern  printEndl
extern  printRAX
extern  exitNormal

extern  parameters
extern  getStats
extern  getStatsExtended

array1      db  10, 11, 12, 13, 13, 14, 15, 16, 17, 11
arraySize   dq  10
max         dq  3
min         dq  3
sum         dq  3   
ave         dq  3
minXmax     dq  3
maxDmin     dq  3


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
; test parameters
;-----------------------------------------------------------------------------------
    
    ; setup variables in the epilog
    mov     rdi, array1         ;param 1
    mov     rsi, [arraySize]    ;param 2
    mov     rdx, max            ;param 3
    mov     rcx, min            ;param 4
    mov     r8, sum             ;param 5
    mov     r9, ave             ;param 6
    push    maxDmin             ;param 7
    push    minXmax             ;param 8
    
    call parameters             ;call the function 
    
    ; epilog
    add rsp, 16                 ;two quadwords are removed from the stack 
    

    ; print out returned values
    mov     rax, [max]
    call    printRAX
    
    mov     rax, [min]
    call    printRAX
    
    mov     rax, [sum]
    call    printRAX
    
    mov     rax, [ave]
    call    printRAX
    
    mov     rax, [minXmax]
    call    printRAX
    
    mov     rax, [maxDmin]
    call    printRAX
   
    call    printEndl           ;blank line to separate outputs

;-----------------------------------------------------------------------------------
; test getStats
;-----------------------------------------------------------------------------------
    
    mov     rdi, array1         ;param 1
    mov     rsi, [arraySize]    ;param 2
    mov     rdx, max            ;param 3
    mov     rcx, min            ;param 4
    mov     r8, sum             ;param 5
    mov     r9, ave             ;param 6
    
    call getStats               ;call the functon
    
    ; print the results
    mov     rax, [max]
    call    printRAX
    
    mov     rax, [min]
    call    printRAX
    
    mov     rax, [sum]
    call    printRAX
    
    mov     rax, [ave]
    call    printRAX
    
    call    printEndl           ;blank line to separate outputs
    
;-----------------------------------------------------------------------------------
; test getStatsExtended
;-----------------------------------------------------------------------------------
    
    mov     rdi, array1         ;param 1
    mov     rsi, [arraySize]    ;param 2
    mov     rdx, max            ;param 3
    mov     rcx, min            ;param 4
    mov     r8, sum             ;param 5
    mov     r9, ave             ;param 6
    push    maxDmin             ;param 7
    push    minXmax             ;param 8
    
    call getStatsExtended       ;call the function
    
    add     rsp, 16;            ; clear the stack 

    ; print the results
    mov     rax, [max]
    call    printRAX
    
    mov     rax, [min]
    call    printRAX
    
    mov     rax, [sum]
    call    printRAX
    
    mov     rax, [ave]
    call    printRAX
    
    mov     rax, [minXmax]
    call    printRAX
    
    mov     rax, [maxDmin]
    call    printRAX
   
    ;exit 
    call    exitNormal
