;------------------------------------------------------------------	
; Data
;------------------------------------------------------------------	
section 	.data
; external functions
extern printEndl
extern printByteArray
extern exitNormal

; propmts, all prompts are the same size but have trailing spaces
passPushPop	db	"PushAll and PopAll Passed                         "
failPushPop	db	"PushAll or PopAll Failed                          "
passDeck	db	"newDeck Passed                                    "
failDeck	db	"newDeck Failed                                    "
dvRows		db	"displayValue Passed if the lines above match      "
dsRows		db	"displaySuit Passed if the lines above match       "
msgSize		dq	0x30

; variables
cards	db	"A23456789TJQK" 
suits	db	"CDSH"



;------------------------------------------------------------------	
; Bss		.bss
;------------------------------------------------------------------	
deck	resb	52



;------------------------------------------------------------------	
; Code 
;------------------------------------------------------------------	
section		.text 



;------------------------------------------------------------------	
; precondition:		None
;
; postcondition: 	The following registers 
;			rax, rbx, rcx rdx, rdi and rsi 
;			have been pushed onto the stack
;
; return: 		n/a
%macro	pushAll 0
; your code goes here
%endmacro
;------------------------------------------------------------------	



;------------------------------------------------------------------	
; precondition:		None
;
; postcondition: 	The following registers 
;			rax, rbx, rcx rdx, rdi and rsi 
;			have been popped onto the stack
;
; return: 		n/a
%macro	popAll 0
; your code goes here
%endmacro
;------------------------------------------------------------------	



;------------------------------------------------------------------	
; precondition:  	an array of 52 bytes has been defined 
;			and the address is passed to this macro
;
; postcondition: 	the numbers 0 through 51 are placed in the 
;			array in that order
;
; return:		n/a
%macro	newDeck 1
; your code goes here
%endmacro
;------------------------------------------------------------------	



;------------------------------------------------------------------	
; precondition:  	a value is passed into macro 
;
; postcondition:  	a random number in the range 1-x is returned	
;			where x is the number passed into the macro
;
; return:		n/a
%macro	random 1
	push rbx
	push rdx
	rdrand rax
	mov rbx, %1
	div rbx
	mov rax, rdx
	inc rax
	pop rdx
	pop rbx
%endmacro
;------------------------------------------------------------------	



;------------------------------------------------------------------	
; precondition:  	a value representing a number between 0 and 51
;			is passed into macro 
;
; postcondition:  	displayValue is called with that number
; 	  		displaySuit is called with that number
;
; return:		n/a
%macro	displayCard 1
	displayValue %1
	displaySuit  %1
%endmacro
;------------------------------------------------------------------	



;------------------------------------------------------------------	
; precondition:  	a value representing a number between 0 and 51
;			is passed into macro 
;			the cards array must exist with 13 distinct values
;
; postcondition:  	the value that represents this card is displayed	
; 	  		the values are found in the array cards 0-12
;			card 13 starts over at 0  (hint: mod 13)
;
; return:		n/a
%macro	displayValue 1
; your code goes here
%endmacro
;------------------------------------------------------------------	



;------------------------------------------------------------------	
; precondition:  	a value representing a number between 0 and 51
;			is passed into macro 
;			the suits array must exist with 4 distinct values
;
; postcondition:  	the value that represents this cards suit is displayed	
; 	  		the values are found in the array cards 0-3
;			0-12 are one suit
;			13-25 are the next suite ... (hint div 13)
;
; return:		n/a
%macro	displaySuit 1
	; save state
	pushAll
	
	mov 	rax, %1	; place the card in rax
	xor 	rdx, rdx	
	mov 	rbx, 0xd	; divide by 13
	div 	rbx
	lea	rsi, 	[suits+rax] ; print suit
	mov	rdx,	0x1
	call	printByteArray	
	; restore state
	popAll
%endmacro
;------------------------------------------------------------------	



global _start

_start:
	;------------------------------------------------------------------	
	; test pushAll and popAll
	;------------------------------------------------------------------	
	mov rax, 0xa
	mov rbx, 0xb
	mov rcx, 0xc
	mov rdx, 0xd
	mov rdi, 0xe
	mov rsi, 0xf
	pushAll

	mov rax, 0x0
	mov rbx, 0x0
	mov rcx, 0x0
	mov rdx, 0x0
	mov rdi, 0x0
	mov rsi, 0x0
	popAll

	cmp 	rax, 0xa
	jne	FailPushPop

	jmp	PassPushPop

	FailPushPop:
	mov	rsi, 	failPushPop
	mov	rdx,	[msgSize]
	call	printByteArray	
	jmp	ExitPushPop
		
	PassPushPop:
	mov	rsi, 	passPushPop
	mov	rdx,	[msgSize]
	call	printByteArray	

	ExitPushPop:
	call	printEndl
	
        ;------------------------------------------------------------------	
	; test newDeck
	;------------------------------------------------------------------	
	; create a new deck
	newDeck deck
	; first off ensure this can be called more than once
	newDeck deck
	
	; Test Create Deck 
	mov 	rcx, 0 
	TestDeck:
	cmp 	cl, byte[deck+rcx]
	jne	FailDeck
	
	inc	rcx
	cmp	rcx, 51
	jle	TestDeck
	jmp	PassDeck
		
	FailDeck:
	mov	rsi, 	failDeck	
	mov	rdx,	[msgSize]
	call	printByteArray	
	jmp	ExitDeck	

	PassDeck:
	mov	rsi, 	passDeck
	mov	rdx,	[msgSize]
	call	printByteArray	

	ExitDeck:	
	call	printEndl
	call	printEndl

	;------------------------------------------------------------------	
	; test	displayValue 
	;------------------------------------------------------------------	
	mov rcx, 0 
	TestValue:
	displayValue	rcx	
	inc	rcx
	cmp	rcx, 51
	jle	TestValue
	call	printEndl
		
	mov	rsi, 	cards	
	mov	rdx,	0xd	
	call	printByteArray	
	call	printByteArray	
	call	printByteArray	
	call	printByteArray	
	call	printEndl
	
	mov	rsi, 	dvRows	
	mov	rdx,	[msgSize]	
	call	printByteArray	
	call	printEndl
	call	printEndl
	
	;------------------------------------------------------------------	
	; test	displaySuit 
	;------------------------------------------------------------------	
	mov rcx, 0 
	TestSuit:
	displaySuit	rcx	
	inc	rcx
	cmp	rcx, 51
	jle	TestSuit
	call	printEndl

	mov	rbx, 0x0
	nextPattern:
	mov	rcx, 0xd
	printPattern:
	lea	rsi, 	[suits+rbx]
	mov	rdx,	0x1	
	call	printByteArray
	loop	printPattern
	inc 	rbx
	cmp	rbx, 5
	jl	nextPattern
	call	printEndl
	
	mov	rsi, 	dsRows	
	mov	rdx,	[msgSize]	
	call	printByteArray	
	call	printEndl
	call	printEndl

	call	exitNormal
