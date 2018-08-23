; Simple example demonstrating basic program 
; format and layout


; ***************************************************************
; Some basic data declarations

section 	.data

; -----
; define constants

EXIT_SUCCESS 	equ 	0	; success 
SYS_exit	equ	60	; call code for terminiate

; -----
; Byte (8-bit) variable declarations

bVar1	db	17
bVar2	db	9
bResult	db	0

; -----
; Word (16-bit) declarations

wVar1	dw	17000
wVar2	dw	9000
wResult	dw	0

; -----
; Double Word (32-bit) declarations

dVar1	dd	17000000
dVar2	dd	9000000
dResult	dd	0

; -----
; Quad Word (64-bit) declarations

qVar1	dq	17000000000
qVar2	dq	9000000000
qResult	dq	0

; ***************************************************************
; Code Section 

section		.text
global _start
_start:
	
; Performs a series of vey basic addition operations
; to demonstrate basic program format.	

; ----------
;	Byte example
;	bResult = bVar1 + bVar2
 
	mov 	al, byte [bVar1]
	add	al, byte [bVar2]
	mov	byte [bResult], al
	
; ----------
;	Word example
;	wResult = wVar1 + wVar2
	mov 	ax, word [wVar1]
	add	ax, word [wVar2]
	mov	word [wResult], ax
	
; ----------
;	Double-word example
;	dResult = dVar1 + dVar2
	mov 	eax, dword [dVar1]
	add	eax, dword [dVar2]
	mov	dword [dResult], eax

; ----------
;	Quadword example
;	qResult = qVar1 + qVar2
	mov 	rax, qword [qVar1]
	add	rax, qword [qVar2]
	mov	qword [qResult], rax

last:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall




