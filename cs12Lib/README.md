# CS12-Lib
This library is needed for some of the labs for CS-12

## Exported Functions:
### printReg
  print the value in the RDI register
 example:
 ```
; Data
section 	.data
extern printReg
extern printRAX
extern printMSG
extern printABCD
extern exitNormal

; Code 
section		.text
	
global _start

_start:

	mov rdi, 0x1234567890ABCD
	call printReg
	call exitNormal
  ```
  
### printRAX
### printRBX
### printRCX
### printRDX
### printABCD
### printMSG
### exitNormal

