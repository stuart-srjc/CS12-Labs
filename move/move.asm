; simple example

section 	.data

; define constants

EXIT_SUCCESS 	equ 	0	; success 
SYS_exit	equ	60	; call code for terminiate

; Byte (8-bit) variable declarations
bVar1	db	0xaa

; Word (16-bit) declarations
wVar1	dw	0xbbbb

; Double Word (32-bit) declarations
dVar1	dd	0xcccccccc

; Quad Word (64-bit) declarations
qVar1	dq	0xdddddddddddddddd

; Code 
section		.text
	
global _start

_start:

	mov 	al, byte [bVar1]    ; 0xaa
	
	mov 	ax, word [wVar1]    ; 0xbbbb
	
	mov 	eax, dword [dVar1]  ; 0xcccccccc

	mov 	rax, qword [qVar1]  ; 0xdddddddddddddddd
	
 	mov 	eax, dword [dVar1]  ; 0xcccccccc
	
	mov 	ax, word [wVar1]    ; 0xbbbb

	mov 	ah, byte [bVar1]    ; 0xaa

last:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall




