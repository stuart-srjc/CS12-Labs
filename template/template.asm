; Data Section
; ############
section 	.data

; ###############################################
; external function references from CS12-Lib
; ###############################################
extern printByteArray
extern printEndl
extern exitNormal

; ###############################################
; Variable Definitions
; ###############################################
helloMsg  db  "CS12"
spacer    db  "                                                                 "
helloLen  dq  60


; BSS Section
; ############ 
section		.bss

; ###############################################
; Variable Declarations
; ###############################################


; Code Section
; ############	
section		.text

; ###############################################
; ### Begin Program 
; ###############################################	
global _start

_start:
; ###############################################
; ###  Print out Header 'CS12' 
; ###############################################
    ; print out the message
    mov rdx, qword [helloLen]   ; load the length of the output
    mov rsi, helloMsg           ; load the message
    call printByteArray         ; print the message
    call printEndl              ; print an endline


; ###############################################
; exit with an exit code of 0
; ###############################################
	call	exitNormal
