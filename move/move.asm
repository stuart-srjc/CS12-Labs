; Data Section
; ############
section 	.data

; ###############################################
; external function references from CS12-Lib
; ###############################################
extern exitNormal
extern printABCD
extern printMSG
extern printRAX
extern printReg
extern printEndl

; ###############################################
; Variable Declarations
; ###############################################
aVal	dq	0xa0a0a0a
bVal 	dq	0x0b0b0b0
cVal 	dq	0x0

; Code Section
; ############
section		.text


; ###############################################
; ### Begin Program ###	
; ###############################################
global _start

_start:
; ###############################################
; move a memory location and print the result
; ###############################################

	mov 	rdi,    qword[aVal]     ; move the value from aVal to rdi 
	call 	printReg                ; call the function printReg
	jmp 	Exit                    ; jmp to Exit bypassing all other code
	
	; NOT LIKE THIS
	mov 	rdi, 	aVal            ; this moves the address, not the value
	call 	printReg                ; call the function printReg
	jmp 	Exit                    ; jmp to Exit bypassing all other code
    call    printEndl

; ###############################################
;Move Reg to memory to Reg
; ###############################################
	mov 	rcx, 	0x0c0c0c0c      ; move a literal to the rcx register
	mov 	qword[cVal], rcx        ; move the value in rcx to cval
	mov 	rdi, 	qword[cVal]     ; move the value from cVal to rdi
	call 	printReg                ; call the function printReg
	jmp 	Exit                    ; jmp to Exit bypassing all other code

; ###############################################
;move immediate to Reg,  Reg to Reg 	
; ###############################################
	mov 	rcx, 	0xabcd
	mov 	rdi, 	rcx
	call 	printReg                ; call the function printReg
	jmp 	Exit                    ; jmp to Exit bypassing all other code

; ###############################################
;move immediate to memory, memory to Reg
; ###############################################
	mov 	qword [cVal], 	0xface
	mov 	rdi, 		[cVal]
	call 	printReg                ; call the function printReg
	jmp 	Exit                    ; jmp to Exit bypassing all other code
	
; ###############################################
;Narrowing Conversion
; ###############################################
	mov 	qword [cVal], 	0x0 ;set cVal to 0
	mov 	rax, 		0x32  ; narrow
	mov 	byte [cVal], 	al
	mov 	rdi, 		[cVal]  ; widen
	call 	printReg                ; call the function printReg
	jmp 	Exit                    ; jmp to Exit bypassing all other code
	
; ###############################################
;Narrowing Conversion, note we truncate the value on this one
; ###############################################
	mov 	qword [cVal], 	0x0 ;set cVal to 0
	mov 	rax, 		0x1f4  ; narrow
	mov 	byte [cVal], 	al
	mov 	rdi, 		[cVal]  ; widen
	call 	printReg                ; call the function printReg
	jmp 	Exit                    ; jmp to Exit bypassing all other code
	
; ###############################################
; movzx vs move for unsigned 
; mov first, note that the output is way to large ffff000a
; ###############################################
	mov 	qword [cVal], 	0xa ;set cVal to a
	mov 	rax, 	0xffff0000
	mov 	al, 	byte [cVal] ; narrow
	call 	printRAX            ; call the function printRAX
	jmp 	Exit

; ###############################################
; movzx vs move for unsigned 
; movzx will zero out the bits giving the desired result
; ###############################################
	mov 	qword [cVal], 	0xa ;set cVal to a
	mov 	rax, 		0xffff0000
	movzx 	rax, 		byte [cVal]  ; narrow
	call 	printRAX            ; call the function printRAX
;	jmp 	Exit
	
; ###############################################
; movsx vs move for signed 
; movsx will zero or ones fill the bits giving the desired result
; example with negative value
; ###############################################
	mov 	bl, 	-1
	movzx 	rax, 	bl; unsigned 
	call 	printRAX            ; call the function printRAX
	movsx 	rax, 	bl; signed
	call 	printRAX            ; call the function printRAX
	jmp 	Exit
	
; ###############################################
; example with positive value
; ###############################################
	mov 	bl,     1	
	movzx 	rax, 	bl; unsigned 
	call 	printRAX            ; call the function printRAX
	movsx 	rax, 	bl; signed
	call 	printRAX            ; call the function printRAX
	jmp 	Exit
	
; ###############################################
; example fo the printABCD function
; ###############################################
	mov rax, 0xAAAA
	mov rbx, 0xBBBB
	mov rcx, 0xCCCC
	mov rdx, 0xDDDD
	call printABCD              ; call the function printABCD
	jmp Exit

; ###############################################
; print all the messages out example 
; ###############################################
	mov rdi, 0                       ; endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 1                       ; MOV 
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 2                       ; ADD
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ; endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 3                       ; SUB
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 4                       ; MUL
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 5                       ; DIV
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 6                       ; Signed
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 7                       ; Unsigned
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 8                       ; Space ' '
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 9                       ; RAX
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 10                      ; RBX
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 11                      ; RCX
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	
	mov rdi, 12                      ; RDX
	call printMSG                    ; call the function printMSG
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	jmp Exit	
	
; ###############################################
; print all the messages out example with jump 	
; ###############################################
	mov rdi, 0                       ;endl
	msgLoop:
	call printMSG                    ; call the function printMSG
	push rdi
	mov rdi, 0                       ;endl
	call printMSG                    ; call the function printMSG
	pop rdi
	inc rdi
	cmp rdi, 13
	jl  msgLoop
 	jmp Exit
	

	Exit:		
	call	exitNormal
