.data
msg:	.ascii 	"Hello World of Assembly!\n"
 	len	=	. - msg
	
.text	
	.global		_start

_start:
	movl	$len,	%edx  # Arg 3
	movl	$msg,	%ecx  # Arg 2
	movl	$1,	%ebx  # Arg 1
	movl	$4, 	%eax  # system call
	int	$0x80

	movl	$0,	%ebx  # Arg 1
	movl	$1, 	%eax  # system call
	int	$0x80


