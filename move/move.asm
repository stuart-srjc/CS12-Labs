; Data
section 	.data

; external function references
extern exitNormal

extern printABCD
extern printMSG
extern printRAX
extern printRBX
extern printRCX
extern printRDX
extern printReg

aVal	dq	0xa0a0a0a
bVal 	dq	0x0b0b0b0
cVal 	dq	0x0

; Code 
section		.text
	
global _start

_start:
	; move memory to reg
	mov 	rdi, 	[aVal]
	call 	printReg
	jmp 	Exit
	
	; NOT LIKE THIS
	mov 	rdi, 	aVal
	call 	printReg
	jmp 	Exit

	;Move Reg to memory to Reg
	mov 	rcx, 	0x0c0c0c0c  
	mov 	[cVal], rcx
	mov 	rdi, 	[cVal]
	call 	printReg
	jmp 	Exit

	;move immediate to Reg,  Reg to Reg 	
	mov 	rcx, 	0xabcd
	mov 	rdi, 	rcx
	call 	printReg 	
	jmp 	Exit

	;move immediate to memory, memory to Reg
	mov 	qword [cVal], 	0xface
	mov 	rdi, 		[cVal]
	call 	printReg
	jmp 	Exit

	;Narrowing Conversion
	mov 	qword [cVal], 	0x0 ;set cVal to 0
	mov 	rax, 		0x32  ; narrow
	mov 	byte [cVal], 	al
	mov 	rdi, 		[cVal]  ; widen
	call 	printReg
	jmp 	Exit
	
	;Narrowing Conversion, note we truncate the value on this one
	mov 	qword [cVal], 	0x0 ;set cVal to 0
	mov 	rax, 		0x1f4  ; narrow
	mov 	byte [cVal], 	al
	mov 	rdi, 		[cVal]  ; widen
	call 	printReg
	jmp 	Exit
	
	; movzx vs move for unsigned 
	; mov first, note that the output is way to large ffff000a
	mov 	qword [cVal], 	0xa ;set cVal to a
	mov 	rax, 		0xffff0000
	mov 	al, 		byte [cVal]  ; narrow
	call 	printRAX
	jmp 	Exit

	; movzx vs move for unsigned 
	; movzx will zero out the bits giving the desired result
	mov 	qword [cVal], 	0xa ;set cVal to a
	mov 	rax, 		0xffff0000
	movzx 	rax, 		byte [cVal]  ; narrow
	call 	printRAX
	jmp 	Exit
	
	; movsx vs move for signed 
	; movsx will zero or ones fill the bits giving the desired result
	; example with negative value
	mov 	bl, 	-1
	movzx 	rax, 	bl; unsigned 
	call 	printRAX
	movsx 	rax, 	bl; signed
	call 	printRAX
	jmp 	Exit
	
	; example with positive value
	mov 	bl,     1	
	movzx 	rax, 	bl; unsigned 
	call 	printRAX
	movsx 	rax, 	bl; signed
	call 	printRAX
	jmp 	Exit
	
	; example fo the printABCD function
	mov rax, 0xAAAA
	mov rbx, 0xBBBB
	mov rcx, 0xCCCC
	mov rdx, 0xDDDD
	call printABCD
	jmp Exit

	; print all the messages out example 
	mov rdi, 0
	call printMSG
	
	mov rdi, 1
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 2
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 3
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 4
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 5
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 6
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 7
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 8
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 9
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 10
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 11
	call printMSG
	mov rdi, 0
	call printMSG
	
	mov rdi, 12
	call printMSG
	mov rdi, 0
	call printMSG
	jmp Exit	
	
	; print all the messages out example with jump 	
	mov rdi, 0
	msgLoop:
	call printMSG
	push rdi
	mov rdi, 0
	call printMSG
	pop rdi
	inc rdi
	cmp rdi, 13
	jl  msgLoop
 	jmp Exit
	

	Exit:		
	call	exitNormal
