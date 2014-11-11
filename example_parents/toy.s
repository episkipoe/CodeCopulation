	.file	"toy.c"
	.section	.rodata
.LC0:
	.string	"hello world"
	.text
.globl helloWorld
	.type	helloWorld, @function
helloWorld:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$.LC0, (%esp)
	call	puts
	leave
	ret
	.size	helloWorld, .-helloWorld
.globl main
	.type	main, @function
main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ecx
	subl	$4, %esp
	call	helloWorld
	addl	$4, %esp
	popl	%ecx
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.2.3 (Ubuntu 4.2.3-2ubuntu7)"
	.section	.note.GNU-stack,"",@progbits
