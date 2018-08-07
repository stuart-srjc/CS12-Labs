; simple example

section 	.data

; define constants

EXIT_SUCCESS 	equ 	0	; success 
SYS_exit	equ	60	; call code for terminiate

; Byte (8-bit) variable declarations

bVar1	db	17
bVar2	db	9
bResult	db	0

; Word (16-bit) declarations

wVar1	dw	17000
wVar2	dw	9000
wResult	dw	0

; Double Word (32-bit) declarations

dVar1	dd	17000000
dVar2	dd	9000000
dResult	dd	0

; Quad Word (64-bit) declarations

qVar1	dq	17000000000
qVar2	dq	9000000000
qResult	dq	0

; Code 

section		.text

%macro writeStdin 2
        mov     rax, 1          ; 1 is write
        mov     rdi, 1          ; 1 is stdout
        mov     rdx, %1         ; write 13 characters
        mov     rsi, %2    ; read from message
        syscall
%endmacro
%macro readStdin 2
        mov     rax, 0          ; 0 is read
        mov     rdi, 0          ; 0 is stdin
        mov     rdx, %1         ; 10 is num chars 
        mov     rsi, %2         ; store in memory location
        syscall
%endmacro

global _start


_start:

	mov 	al, byte [bVar1]
	add	al, byte [bVar2]
	mov	byte [bResult], al
	
	mov 	ax, word [wVar1]
	add	ax, word [wVar2]
	mov	word [wResult], ax
	
	mov 	eax, dword [dVar1]
	add	eax, dword [dVar2]
	mov	dword [dResult], eax

	mov 	rax, qword [qVar1]
	add	rax, qword [qVar2]
	mov	qword [qResult], rax

last:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall




