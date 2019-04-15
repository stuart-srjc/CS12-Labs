;------------------------------------------------------------------	
; Data
;------------------------------------------------------------------	
section 	.data
; external functions
extern printMSG
extern printRAX
extern printSpace
extern printEndl
extern printByteArray
extern exitNormal

; propmts, all prompts are the same size but have trailing spaces
passPushPop	db	"PushAll and PopAll Passed                         "
failPushPop	db	"PushAll or PopAll Failed                          "
passDeck	db	"newDeck Passed                                    "
failDeck	db	"newDeck Failed                                    "
twoRows		db	"displayValue Passed if the lines above match      "
msgSize		dq	0x30

; variables
cards	db	"A23456789TJQK" 
suits	db	"CDSH"
hand	db	0,0,0,0,0


;------------------------------------------------------------------	
; Bss		.bss
;------------------------------------------------------------------	
section 	.bss
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
	
	mov 	rax, 	%1	; place the card in rax
	xor 	rdx, 	rdx	
	mov 	rbx, 	0xd	; divide by 13
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
	; CS12 Header
	mov rdi, 0xd
	call printMSG
	call printEndl
	
	; create a new deck (in order)
	newDeck deck
	
	; Display The Deck 
	mov 	rcx, 0 
	mov 	rbx, 0xd
	loopCards:
	displayCard	rcx
	mov 	rdx, 0
	mov 	rax, rcx
	div 	rbx
	cmp 	rdx, 0xc 
	jne 	noEndl
	call	printEndl
	jmp 	noSpaces
	noEndl:
	call	printSpace
	call	printSpace
	noSpaces:
	inc	rcx
	cmp	rcx, 51
	jle	loopCards
	
	call	printEndl
	call	printEndl
	
	;pick out 5 cards at random
	
	mov 	rcx, 5
	handPicker:	
	random 	52
	mov	byte [hand-1+rcx], al 
	displayCard	rax	
	call	printSpace
	dec	rcx
	jnz handPicker

	call	printEndl
	call	printEndl
	
	xor	rax, rax	
	mov	al,	byte [hand]
	displayCard	rax	
	call	printEndl

	mov	al,	byte [hand+1]
	displayCard	rax	
	call	printEndl

	mov	al,	byte [hand+2]
	displayCard	rax
	call	printEndl

	mov	al,	byte [hand+3]
	displayCard	rax
	call	printEndl

	mov	al,	byte [hand+4]
	displayCard	rax
	call	printEndl

	
	call	exitNormal
