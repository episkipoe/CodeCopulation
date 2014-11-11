	.file	"toy2.c"
	.section .rdata,"dr"
LC0:
	.ascii "goodbye world\12\0"
	.text
.globl _goodbye
	.def	_goodbye;	.scl	2;	.type	32;	.endef
_goodbye:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$LC0, (%esp)
	call	_printf
	leave
	ret
	.def	___main;	.scl	2;	.type	32;	.endef
.globl _main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	movl	$0, %eax
	addl	$15, %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	call	__alloca
	call	___main
	call	_goodbye
	leave
	ret
	.def	_printf;	.scl	3;	.type	32;	.endef
