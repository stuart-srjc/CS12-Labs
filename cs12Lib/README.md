# CS12-Lib
This library is needed for some of the labs for CS-12

## Exported Functions:
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
  1234567890abcd
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
  1234567890abcd
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
  1234567890abcd
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
  1234567890abcd
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
  1234567890abcd
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
  AAAA
  BBBB
  CCCC
  DDDD
  ```

### printMSG
#### print the message associated with the value in RDI
##### 0x0 0XA (ENDL)
##### 0x1 MOV
##### 0x2 ADD
##### 0x3  SUB
##### 0x4  MUL
##### 0x5  DIV
##### 0x6  Signed
##### 0x7  Unsigned
##### 0x8  ' ' (SPACE)
##### 0x9  RAX
##### 0xA RBX
##### 0xB RCX
##### 0xC RDX
##### 0xD CS12



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

