# CS12-Lib
This library is needed for some of the labs for CS-12

## Exported Functions:

Output Functions
* [printByteArray](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printbytearray)
* [printEndl](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printendl)
* [printMSG](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printmsg)
* [printSpace](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printspace)


Output Register Functions
* [printABCD](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printabcd)
* [printRAX](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printrax)
* [printRBX](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printrbx)
* [printRCX](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printrcx)
* [printRDX](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printrdx)
* [printReg](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#printreg)

Input Functions
* [getByteArray](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#getbytearray)
* [getQuad](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#getquad)

Exit Function
* [exitNormal](https://github.com/stuart-srjc/CS12-Labs/blob/master/cs12Lib/README.md#exitnormal)



### printReg
#### print the value in the RDI register
example: 
 ```
; Data
section 	.data
extern printReg

; Code 
section		.text
	
global _start

_start:

	mov rdi, 0x1234567890ABCD
	call printReg
  ```
  output:
  ```
  0x1234567890abcd
  ```
  
### printRAX
#### print the value in the RAX register
example:
 ```
; Data
section 	.data
extern printRAX
extern exitNormal

; Code 
section		.text
	
global _start

_start:
	mov rax, 0x1234567890ABCD
	call printRAX
  ```
    output:
  ```
  0x1234567890abcd
  ```

### printRBX
#### print the value in the RBX register
example:
 ```
; Data
section 	.data
extern printRBX

; Code 
section		.text
	
global _start

_start:

	mov rbx, 0x1234567890ABCD
	call printRBX
 ```
  output:
  ```
  0x1234567890abcd
  ```

### printRCX
#### print the value in the RCX register
example:
 ```
; Data
section 	.data
extern printRCX

; Code 
section		.text
	
global _start

_start:

	mov rcx, 0x1234567890ABCD
	call printRCX
  ```
  output:
  ```
  0x1234567890abcd
  ```
  
### printRDX
#### print the value in the RDX register
example:
 ```
; Data
section 	.data
extern printRDX

; Code 
section		.text
	
global _start

_start:

	mov rdx, 0x1234567890ABCD
	call printRDX
  ```
  output:
  ```
  0x1234567890abcd
  ```

### printABCD
#### print the value in the RAX, RBX, RAX and RDX registers
example:
 ```
; Data
section 	.data
extern printABCD

; Code 
section		.text
	
global _start

_start:
	mov rax, 0xAAAA
	mov rbx, 0xBBBB
	mov rcx, 0xCCCC
	mov rdx, 0xDDDD
	call printABCD
  ```
  output:
  ```
  0x000000000000AAAA
  0x000000000000BBBB
  0x000000000000CCCC
  0x000000000000DDDD
  ```

### printMSG
#### print the message associated with the value in RDI
##### 0x0  0XA (ENDL)
##### 0x1  MOV
##### 0x2  ADD
##### 0x3  SUB
##### 0x4  MUL
##### 0x5  DIV
##### 0x6  Signed
##### 0x7  Unsigned
##### 0x8  ' ' (SPACE)
##### 0x9  RAX
##### 0xA  RBX
##### 0xB  RCX
##### 0xC  RDX
##### 0xD  CS12
##### 0xE  AND
##### 0xF  OR
##### 0x10 XOR
##### 0x11 NOT
##### 0x12 SHIFT
##### 0x13 ROTATE
##### 0x14 LEFT
##### 0x15 RIGHT
##### 0x15 "Enter up to a quadword in hex: example:ABCDEF1234567890"

example:
 ```
; Data
section 	.data
extern printMSG

; Code 
section		.text
	
global _start

_start:

    mov rdi, 0x1
    call printMSG
  ```
 output:
  ```
  MOV
  ```


### printEndl
#### print the endline character

example:
 ```
; Data
section 	.data
extern printEndl

; Code 
section		.text
	
global _start

_start:

    call printEndl
  ```
 output:
  ```
  
  ```


### printSpace
#### print a space character

example:
 ```
; Data
section 	.data
extern printSpace

; Code 
section		.text
	
global _start

_start:

    call printSpace
  ```
 output:
  ```
   
  ```
### getQuad
#### get a Quad Word from the user and put the result in RAX
#### the user will type in characters 0-9,a-f,A-F. 
#### this will be translated into a quad word and put in the RAX Register
```
; Data
section 	.data
extern printMSG
extern printRAX
extern printEndl
extern getQuad
extern exitNormal

; Code 
section		.text

global _start
_start:
	; output message to user to input a Quad Word
	mov rdi, 0x16
	call printMSG
	call printEndl	; endline
	
	; get a 16byte entry from the user that represents a quadword
	call getQuad
	call printRAX ; print the result
	
	call	exitNormal
 ```
 
 output:
  ```
Enter up to a quadword in hex: example:ABCDEF12345678
123456abcd
0x000000123456ABCD
```

### getByteArray
#### bytes are placed in memory starting at the address pointed to by the RSI Register
#### the number of bytes read into memory is the value in RDX
```
; Data
section 	.data
extern getByteArray
extern printByteArray
extern printEndl
extern exitNormal
array	 	db	"Input 16 bytes  "
numberOfBytes	dq	0x10


; Code 
section		.text

global _start
_start:

	; printByteArray 
	mov rsi, array	 		; note moving the address not the value
	mov rdx, [numberOfBytes]	; print this many bytes of the array, value not address
	call printByteArray		; print the array
	call printEndl
	
	; getByteArray 
	mov rsi, array	 		; note moving the address not the value
	mov rdx, [numberOfBytes]	; get this many bytes of the array, value not address
	call getByteArray		; get the array
	
	; printByteArray 
	mov rsi, array	 		; note moving the address not the value
	mov rdx, [numberOfBytes]	; print this many bytes of the array, value not address
	call printByteArray		; print the array
	call printEndl
	
	call	exitNormal
```
```
Input 16 bytes  
abcdefghijklmnop
abcdefghijklmnop
```

### printByteArray
#### bytes are printed to the screen as they are read from memory starting at the address pointed to by the RSI Register
#### the number of bytes read into memory is the value in RDX
```
; Data
section 	.data
extern printByteArray
extern printEndl
extern exitNormal
arrayToPrint	db	"Print This Array"
numberOfBytes	dq	0x10

; Code 
section		.text

global _start
_start:
	; printByteArray 
	mov rsi, arrayToPrint 		; note moving the address not the value
	mov rdx, [numberOfBytes]	; print this many bytes of the array, value not address
	call printByteArray		; print the array
	
	call printEndl
	call	exitNormal
```
 
output:
```
Print This Array
```

### exitNormal
#### Exit to Linux with returning 0
example:
 ```
; Data
section 	.data
extern exitNormal

; Code 
section		.text
	
global _start

_start:

	call exitNormal
  ```

