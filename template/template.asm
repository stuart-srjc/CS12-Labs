; Data
section 	.data
extern printMSG
extern exitNormal

; Code 
section		.text
	
global _start

_start:
	mov rdi, 0xd
	call printMSG
	
	mov rdi, 0x0
	call printMSG
	
	
	call	exitNormal
