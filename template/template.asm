; Data
section 	.data
extern printByteArray
extern printEndl
extern exitNormal
helloMsg  db  "CS12"
spacer    db  "                                                                 "
helloLen  dq  60

; BSS 
section		.bss
	
; Code 
section		.text
	
global _start

_start:
    ; print out the message
    mov rdx, qword [helloLen]   ; load the length of the output
    mov rsi, helloMsg           ; load the message
    call printByteArray         ; print the message
    call printEndl              ; print an endline

	; exit with an exit code of 0
	call	exitNormal
