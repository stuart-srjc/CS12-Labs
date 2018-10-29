; Data
section 	.data
extern getRand 
extern printEndl
extern printByteArray
extern printMSG
extern printReg
extern printRAX
extern printRBX
extern printRDX
extern exitNormal

mMulby4	db    "Mulby4(x)                                      "
mPa		db	"Print Rax                                              "
mPr		db	"Print Reg                                          "
mPrX	db	"Print Reg X Times                                     "
mRand	db	"Rand                                             "
mRandA	db	"Rand Rax                                      "
msgLen	dq	0x20

; Code 
section		.text

; Single Line Macro
; mulby4(x)	
; description:		shifts the value left 2 times
; precondition:		the macro is called with mulby4(x) and x is a <dest>
; postcondition:	the value X is multiplied by 4
;				all registers are preserved, unless passed in as x
;return:			n/a
%define   mulby4(x)  
; Multi Line Macro format
;pa
;description:		prints the value of RAX using the printRAX function
;precondition:		RAX should contain the desired value to be output
;postcondition:		the contents of RAX are displayed 
;				all registers are preserved
;return:			n/a
%macro pa 0
%endmacro	    

; Multi Line Macro with parameters
;pm	
;description:		prints the byte array passed to the macro
;parameters		%1  the byteArray to be displayed
;				%2 the number of characters to be displayed
;precondition:		the desired byte array and number of characters to be output is passed into the  macro
;postcondition:		the contents of the byte array is displayed 
;				all registers are preserved
;return:			n/a
 %macro pm 2
	push 	rsi
	push	rdx
	mov 	rsi, 		%1
	mov		rdx, 	%2
	call 		printByteArray
	call		printEndl
	pop 	rdx
	pop		rsi
%endmacro	    

; Multi Line Macro with parameters
;pr	
;description:		prints the value passed to the macro using the printReg function
;parameters		%1  the value to be displayed
;precondition:		the desired value to be output is passed into the  macro
;postcondition:		the contents of x is displayed 
;				all registers are preserved
;return:			n/a
%macro pr 1
	
%endmacro	    

; Multi Line Macro with parameters and a label
;prXtimes
;description:		prints the value passed to the macro 
;				multiple times using the printReg function
;parameters		%1  the value to be displayed
;				%2 the number of times to display the value:
;precondition:		the desired value to be outputi is passed into the macro
;				the desired number of times to print the value is passed into the macro
;postcondition:		the contents of the first parameter is displayed  2nd parameter times
;				all registers are preserved
;return:			n/a
%macro prXtimes 2

%endmacro	    

; Multi Line Macro with parameters and a label
;rand			
;description: 		macro to get a random number from 1 to x
;parameters		%1  the max value of the rand number to return qword or register
;precondition:		the desired max value to be output is passed into the macro
;postcondition:		the value of the passed in parameter is now a rand number
;				side effects to registers may occur  in rbx, rcx and rdx
;return:			rax has a random value between 0 and the passed in parameter

%macro rand 1
	
%endmacro

;randP			
;description: 		macro to get a random number from 1 to x
;parameters		%1  the max value of the rand number to return qword or register
;precondition:		the desired max value to be output is passed into the macro
;postcondition:		the value of the passed in parameter is now a rand number
;				all registers are preserved, unless passed in as parameter 1
;return:			rax has a random value between 0 and the passed in parameter

%macro randA 1
	
%endmacro


global _start

_start:

; ------------------------------ output header
	mov rdi, 0xd
	call printMSG
	
	mov rdi, 0x0
	call printMSG
	call printEndl
	
jmp end
; ---------------------------------- test Multiply by 4	
	pm	mMulby4,  [msgLen]
        mov rax, 0x1
	call printRAX
	call printEndl
	
	mulby4(rax)
	;call printRAX
	pa
	call printEndl
	
	
jmp end	
; ---------------------------------- test Print Reg	
	pm	mPr, [msgLen]
	pr		rax	
	call printEndl
	
jmp end
; ---------------------------------- test Print Reg x times	
	pm	mPrX, [msgLen]

	prXtimes	rax, 0x3, 
	call printEndl
	
	prXtimes	rax, 0x2, 
	call printEndl
	
	prXtimes	rax, 0x2, 
	call 		printEndl
	
jmp end	
; ---------------------------------- test Random with Side Effects on RDX	
	pm	mRand, [msgLen]
	rand	0x20
	pa
	call	printRBX
	call	printRDX
	rand	0x20
	pa
	call	printRBX
	call	printRDX
	rand	0x20
	pa
	call	printRBX
	call	printRDX
	rand	0x20
	pa
	call	printRBX
	call	printRDX
	call 	printEndl
	
	mov	rbx, 0xff
	mov	rdx, 0xff

jmp end
; ---------------------------------- test Random with no side effects on RDX	
	pm	mRandA, [msgLen]

	rand	0x22
	call	printRBX
	call	printRDX
	rand	0x23
	call	printRBX
	call	printRDX
	rand	0x24
	call	printRBX
	call	printRDX
	rand	0x25
	call	printRBX
	call	printRDX
	call 	printEndl
	
	mov	rbx, 0xff
	mov	rdx, 0xff
	randA	0x20
	call	printRBX
	call	printRDX
	randA	0x20
	call	printRBX
	call	printRDX
	randA	0x20
	call	printRBX
	call	printRDX
	randA	0x20
	call	printRBX
	call	printRDX
	call 	printEndl


end:
	call	exitNormal
