; Data
section     .data
extern  printMSG
extern  printEndl
extern  printRAX
extern  printRCX
extern  exitNormal

; Code 
section     .text


;-----------------------------------------
; declare functions
global parameters 
global getStats
global getStatsExtended 


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
;-----------------------------------------

;-----------------------------------------
; additional parameters are passed on the stack in reverse order
;-----------------------------------------
;  push the last parameter
;  push the second to last parameter
;  ...
;-----------------------------------------

;-----------------------------------------------------------------------------------
; parameters 
; description:      first parameter is a pointer to an array of bytes
;                   second parameter is the number of bytes in the array
;                   returns a the following 
;                   rdx                 first byte of the array
;                   rcx                 second byte of the array 
;                   r8                  third byte of the array
;                   r9                  fourth byte of the array
;                   Stack parameter 1   fifth byte of the array
;                   Stack parameter 2   sixth byte of the array
;
; precondition:     rdi points to an array of bytes
;                   rsi is a quadword with the value being the number of elements in the array
;                   rdx                 is the address to return byte 1 
;                   rcx                 is the address to return byte 2
;                   r8                  is the address to return byte 3  
;                   r9                  is the address to return byte 4  
;                   Stack parameter 1   is the address to return byte 5 
;                   Stack parameter 2   is the address to return byte 6 
;
; postcondition:    rdx                 first byte of the array
;                   rcx                 second byte of the array 
;                   r8                  third byte of the array
;                   r9                  fourth byte of the array
;                   Stack parameter 1   fifth byte of the array
;                   Stack parameter 2   sixth byte of the array
;           
;
; return            n/a 
;-----------------------------------------------------------------------------------
parameters:

    ;prologue
    ; push the rbp value to the stack
    push rbp
    ; save the stack pointer into rbp
    mov rbp, rsp
    ; save any registers that will be used for calculations
    push r15
    
    ; rdx byte 1
    mov rax, 0x0
    
    mov al, byte[rdi]
    mov qword[rdx], rax

    mov al, byte[rdi+1]
    mov qword[rcx], rax

    mov al, byte[rdi+2]
    mov qword[r8], rax

    mov al, byte[rdi+3]
    mov qword[r9], rax


    mov r15, qword [rbp+16]; parameter 7
    mov al, byte[rdi+4]
    mov qword[r15], rax
  
    mov r15, qword [rbp+24]; parameter 8
    mov al, byte[rdi+5]
    mov qword[r15], rax

    ;epilogue
    ; pop the saved registers
    pop r15
    ; pop the rbp
    pop rbp
    
    ret
    

;-----------------------------------------------------------------------------------
; getStats 
; description:      first parameter is a pointer to an array of bytes
;                   second parameter is the number of bytes in the array
;                   returns a the following 
;                   rdx largest number passed into the function 
;                   rcx smallest number passed into the function 
;                   r8  the sum of the numbers passed into the function 
;                   r9  the average of the numbers passed into the function 
;
; precondition:     rdi points to an array of bytes
;                   rsi is a quadword with the value being the number of elements in the array
;                   rdx is the address of a quadword to store the max
;                   rcx is the address of a quadword to store the min
;                   r8  is the address of a quadword to store the sum of the numbers
;                   r9  is the address of a quadword to store the average of the numbers
;
; postcondition:    rdx largest number passed into the function 
;                   rcx smallest number passed into the function 
;                   r8  the sum of the numbers passed into the function 
;                   r9  the average of the numbers passed into the function 
;           
;
; return            n/a 
;-----------------------------------------------------------------------------------
getStats:
   
    ; rdi array of bytes 
    ; rsi is a quadword with the value being the number of elements in the array
    ; rdx is the address of a quadword to store the max
    ; rcx is the address of a quadword to store the min
    ; r8  is the address of a quadword to store the sum of the numbers
    ; r9  is the address of a quadword to store the average of the numbers

    ;prologue
    push r14
    push r15
     
    ; max
    mov r15, rsi ; set the counter to start at the last value in the array
    
    mov rax, 0x0 
    mov al, byte [rdi+r15-1]
    nextMax:
    dec r15
    cmp r15, 0x0
    jbe Max
    cmp al, byte [rdi+r15-1]
    jb greater
    jmp nextMax

    greater:
    mov al, byte [rdi+r15-1]
    jmp nextMax    

    Max:
    push rax ; put the value on the stack to pick up later

    ; min
    mov r15, rsi ; set the counter to start at the last value in the array
    
    mov rax, 0x0 
    mov al, byte [rdi+r15-1]

    nextMin:
    dec r15
    cmp r15, 0x0
    jbe Min
    cmp al, byte [rdi+r15-1]
    ja lesser
    jmp nextMin

    lesser:
    mov al, byte [rdi+r15-1]
    jmp nextMin

    Min:
    push rax ; put the value on the stack to pick up later
    
    ; sum
    mov r15, rsi ; set the counter to start at the last value in the array
    
    mov rax, 0x0 
    mov al, byte [rdi+r15-1]

    nextSum:
    dec r15
    cmp r15, 0x0
    jbe Sum
    mov r14b, byte[rdi+r15-1]
    add rax, r14
    jmp nextSum

    Sum:
    push rax ; put the value on the stack to pick up later
    
    ; ave
    push rdx
    mov rdx, 0x0
    div rsi
    mov qword[r9], rax ; set the return value for ave
    pop rdx
    
    ; pull values from the stack
    pop qword [r8]      ; sum
    pop qword [rcx]     ; min
    pop qword [rdx]     ; max
   
    mov rax, qword[r8]
    
    ;epilogue
    pop r15
    pop r14

    ret
    
;-----------------------------------------------------------------------------------
; getStatsExtended 
; description:      first parameter is a pointer to an array of bytes
;                   second parameter is the number of bytes in the array
;                   returns a the following 
;                   rdx largest number passed into the function 
;                   rcx smallest number passed into the function 
;                   r8  the sum of the numbers passed into the function 
;                   r9  the average of the numbers passed into the function
;                   Stack parameter 1 min*max the minimum number mulitiplied times the maximum 
;                   Stack parameter 2 max/min the maximum number divided by the minimum number
;
; precondition:     rdi points to an array of bytes
;                   rsi is a quadword with the value being the number of elements in the array
;                   rdx is the address of a quadword to store the max
;                   rcx is the address of a quadword to store the min
;                   r8  is the address of a quadword to store the sum of the numbers
;                   r9  is the address of a quadword to store the average of the numbers
;                   Stack parameter 1 min*max the minimum number mulitiplied times the maximum 
;                   Stack parameter 2 max/min the maximum number divided by the minimum number
;
; postcondition:    rdx largest number passed into the function 
;                   rcx smallest number passed into the function 
;                   r8  the sum of the numbers passed into the function 
;                   r9  the average of the numbers passed into the function 
;                   Stack parameter 1 min*max the minimum number mulitiplied times the maximum 
;                   Stack parameter 2 max/min the maximum number divided by the minimum number
;           
;
; return            n/a 
;-----------------------------------------------------------------------------------
getStatsExtended:
    ; rdi array of bytes 
    ; rsi is a quadword with the value being the number of elements in the array
    ; rdx is the address of a quadword to store the max
    ; rcx is the address of a quadword to store the min
    ; r8  is the address of a quadword to store the sum of the numbers
    ; r9  is the address of a quadword to store the average of the numbers
    ; Stack parameter 1 min*max the minimum number mulitiplied times the maximum 
    ; Stack parameter 2 max/min the maximum number divided by the minimum number

    ;prologue
    ; push the rbp value to the stack
    ;TBD 

    ; save the stack pointer into rbp
    ; TBD

    ; save any registers that will be used for calculations
    ; TBD
     
    ; max
    mov r15, rsi ; set the counter to start at the last value in the array
    
    mov rax, 0x0 
    mov al, byte [rdi+r15-1]
    nextMaxE:
    dec r15
    cmp r15, 0x0
    jbe MaxE
    cmp al, byte [rdi+r15-1]
    jb greaterE
    jmp nextMaxE

    greaterE:
    mov al, byte [rdi+r15-1]
    jmp nextMaxE    

    MaxE:
    push rax ; put the value on the stack to pick up later

    ; min
    mov r15, rsi ; set the counter to start at the last value in the array
    
    mov rax, 0x0 
    mov al, byte [rdi+r15-1]

    nextMinE:
    dec r15
    cmp r15, 0x0
    jbe MinE
    cmp al, byte [rdi+r15-1]
    ja lesserE
    jmp nextMinE

    lesserE:
    mov al, byte [rdi+r15-1]
    jmp nextMinE

    MinE:
    push rax ; put the value on the stack to pick up later
    
    ; sum
    mov r15, rsi ; set the counter to start at the last value in the array
    
    mov rax, 0x0 
    mov al, byte [rdi+r15-1]

    nextSumE:
    dec r15
    cmp r15, 0x0
    jbe SumE
    mov r14b, byte[rdi+r15-1]
    add rax, r14
    jmp nextSumE

    SumE:
    push rax ; put the value on the stack to pick up later
    
    ; ave
    push rdx
    mov rdx, 0x0
    div rsi
    mov qword[r9], rax ; set the return value for ave
    pop rdx
    
    ; pull values from the stack
    pop qword [r8]      ; sum
    pop qword [rcx]     ; min
    pop qword [rdx]     ; max
  
    ; multiply min times max return in 7th parameter
    ; TBD 
    
    ; divide max by min return in 8th parameter
    ; TBD

    ;epilogue
    ; pop the saved registers
    ; TBD

    ; pop the rbp
    ; TBD
 
    ret
    
