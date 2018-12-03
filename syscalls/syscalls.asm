; Data
section 	.data

    messageIn       db      "                       "
message         db      "Hello World of Assembly"
msgsize         equ     23
endl            db      0x0a
errorMsg        db      "Errror opening file!   "
errorMsgSize    equ     23

exit_success 	equ 	0x0	    ; success 
sys_exit	    equ	    0x3c	; call code for terminiate
sys_write       equ     0x1     ; value of sys_write in linux
sys_stdout      equ     0x1     ; value of sys_stdout in linux
sys_read        equ     0x0     ; value of sys_read in linux
sys_stdin       equ     0x0     ; value of sys_stdin in linux
sys_open        equ     0x2     ; value of sys_open in linux
sys_close       equ     0x3     ; value of sys_open in linux
sys_create      equ     0x55    ; value of sys_create in linux

O_RDONLY        equ     000000q ; read only
O_WRONLY        equ     000001q ; write only
O_RDWR          equ     000002q ; read and write

S_IRUSR         equ     00400q ; owner, read permission 
S_IWUSR         equ     00200q ; owner, write permission 
S_IXUSR         equ     00100q ; owner, exec permission 

; File related variables
fd              dq      0x0
outFile         db      "outputFile.txt"
outFileNull     db      0x0
inFile          db      "inputFile.txt"
inFileNull      db      0x0
inFileSize      equ     0x57
   
; Bss
section     .bss
inFileData      resb    90
 
; Code 
section		.text
	
global _start

_start:
;-----------------------------------------------------------------------------------
    ;output the default message "Hello World of Assembly!"
;-----------------------------------------------------------------------------------
	mov rax, sys_write 
    mov , sys_stdout
    mov , message
    mov , msgsize 
    syscall	
	
	; output newline
	mov , sys_write 
    mov , sys_stdout
    mov , endl 
    mov , 1 
    syscall	

;-----------------------------------------------------------------------------------
    ;input the users message
;-----------------------------------------------------------------------------------
	mov , sys_read
    mov , sys_stdin
    mov , messageIn
    mov , msgsize 
    syscall	

;-----------------------------------------------------------------------------------
    ;output the users message
;-----------------------------------------------------------------------------------
	mov , sys_write 
    mov , sys_stdout
    mov , messageIn
    mov , msgsize 
    syscall	

	; output newline
	mov , sys_write 
    mov , sys_stdout
    mov , endl 
    mov , 1 
    syscall	

;-----------------------------------------------------------------------------------
	; open the file 'outputFile.txt' (S_IRUSR | S_IWUSR)
;-----------------------------------------------------------------------------------
    mov , sys_create
    mov , outFile
    mov , S_IRUSR | S_IWUSR 
    syscall	

    mov qword [fd], rax ; save the file descriptor
    call    printRAX
    cmp rax, 0 
    jl fileError
    jmp noError    
    
    fileError:
    ; print error and exit 
	mov rax, sys_write 
    mov rdi, sys_stdout
    mov rsi, errorMsg
    mov rdx, errorMsgSize 
    syscall	
    jmp exit

    noError:
     
;-----------------------------------------------------------------------------------
    ; output the users message to file
;-----------------------------------------------------------------------------------
	mov , sys_write 
    mov , qword[fd]; move file descriptor to rdi
    mov , messageIn
    mov , msgsize 
    syscall
    cmp rax, 0 
    jl fileError
	
;-----------------------------------------------------------------------------------
    ; output newline to the file
;-----------------------------------------------------------------------------------
	mov , sys_write 
    mov , qword[fd]; move file descriptor to rdi
    mov , endl 
    mov , 1 
    syscall	

;-----------------------------------------------------------------------------------
	; close the file 'outputFile.txt'
;-----------------------------------------------------------------------------------
    mov , sys_close
    mov , qword [fd]
    syscall
   

;-----------------------------------------------------------------------------------
	; open the file 'inputFile.txt' (O_RDONLY)
;-----------------------------------------------------------------------------------
    mov , sys_open
    mov , inFile
    mov , O_RDONLY
    syscall	
    mov qword [fd], rax ; save the file descriptor
    call    printRAX
    cmp rax, 0 
    jl fileError
    
     
;-----------------------------------------------------------------------------------
    ; input the users message from file
;-----------------------------------------------------------------------------------
	mov , sys_read 
    mov , qword[fd]; move file descriptor to rdi
    mov , inFileData 
    mov , inFileSize
    syscall
    cmp rax, 0 
    jl fileError

;-----------------------------------------------------------------------------------
	; close the file 'inputFile.txt'
;-----------------------------------------------------------------------------------
    mov , sys_close
    mov , qword [fd]
    syscall
   
;-----------------------------------------------------------------------------------
    ;output the users message
;-----------------------------------------------------------------------------------
	mov , sys_write 
    mov , sys_stdout
    mov , inFileData 
    mov , inFileSize
    syscall	

	; output newline
	mov , sys_write 
    mov , sys_stdout
    mov , endl 
    mov , 1 
    syscall	
         
    exit:
;-----------------------------------------------------------------------------------
    ; exit normally
;-----------------------------------------------------------------------------------
	mov , sys_exit
    mov , exit_success
    syscall	
