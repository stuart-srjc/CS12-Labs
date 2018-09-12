; simple example

section 	.data

; define constants

EXIT_SUCCESS 	equ 	0	; success 
SYS_exit	equ	60	; call code for terminiate

number: dq	123456789 
print:  dq	0
nl:     dq	0xa
input:  TIMES 	40 	dq	0
temp:  TIMES 	40 	dq	0

; Code 

section		.text
global _start

%macro  exitNormal 0
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall
%endmacro

%macro readChars 2
	mov	rax, 0          ; 0 is read
	mov	rdi, 0          ; 0 is stdin
	mov	rdx, %1         ; num chars 
	mov	rsi, %2         ; store in memory location
	syscall
%endmacro

%macro writeChars 2
	mov	rax, 1          ; 1 is write
	mov	rdi, 1          ; 1 is stdout
	mov	rdx, %1         ; write 13 characters
	mov	rsi, %2    ; read from message
	syscall
%endmacro

%macro  newLine 0
	mov	rax, 1         ; 1 is write
	mov	rdi, 1         ; 1 is stdout
	mov	rdx, 1         ; write 1 characters
	mov	rsi, nl      ; read from nl
	syscall
%endmacro

%macro printNumber 1
	; CURRENTLY PRINTS BACKWARDS
        ; since its a quad word the largest is 10^38
        ; start there and do a compare if >= start
        ; if < /=10 and loop
        ; start means div, 
        ; print the div
	; replace the number with the mod
	; loop, but not all the way to the top, just the start
	; compare before the loop if 0 your done
	myLoop:	

	;try pushing into an array 	
	mov	rcx, 	0
	
	mov     rax, qword [%1]
	mov 	rdx, 0
	mov 	rbx, 10
	div 	rbx
	add	rdx, 0x30
	mov     qword [print], rdx
	mov	qword [number], rax 
	cmp	qword [number], 0
	jg	myLoop
	writeChars	40, 	temp 
%endmacro

%macro chars2Number 1
	; Not complete
	; essentially, find the end of the list first null
	; from the end multiply times 1 and add
        ; make the multiplier *10 and add
        ; repeat until 0 
	myLoop:	
	mov     rax, qword [%1]
	mov 	rdx, 0
	mov 	rbx, 10
	div 	rbx
	add	rdx, 0x30
	mov     qword [print], rdx
	mov	qword [number], rax 
	mov	rax, 1
	mov	rdi, 1
        mov     rsi, print
	mov	rdx, 1
	syscall
	cmp	qword [number], 0
	jg	myLoop
%endmacro

_start:
	;readChars 40, input
 	;writeChars 40, input	
        ;chars2Number 40, input	
	mov rax, 0xaa
	
	numLoop:	

	;try pushing into an array 	
	mov	rcx, 	0
	
	;mov     rax, qword [%1]
	mov 	rdx, 0
	mov 	rbx, 10
	div 	rbx
	add	rdx, 0x30
	mov     qword [print], rdx
	mov	qword [number], rax 
	cmp	qword [number], 0
	jg	numLoop
	writeChars	40, 	temp 

	newLine
	exitNormal	




