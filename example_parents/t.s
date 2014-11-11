LC0:
	.ascii "hello world\12\0"
.text
LC1:
	.ascii "goodbye world\12\0"
.text
.globl _helloWorld
	.def	_helloWorld;	.scl	2;	.type	32;	.endef
_helloWorld:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$LC0, (%esp)
	call	_printf
	leave
	ret
.globl ___main
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
	call	_helloWorld
	leave
	ret
.globl _printf
	.def	_printf;	.scl	3;	.type	32;	.endef
.endef
.globl _helloWorld_goodbye
	.def	_helloWorld_goodbye;	.scl	2;	.type	32;	.endef

_helloWorld_goodbye:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$LC0, (%esp)
	call	_printf
	leave
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$LC1, (%esp)
	call	_printf
	leave
	ret
.globl _goodbye
	.def	_goodbye;	.scl	2;	.type	32;	.endef
_goodbye:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$LC1, (%esp)
	call	_printf
	leave
	ret
.globl ___main
	.def	___main;	.scl	2;	.type	32;	.endef
.globl _printf
	.def	_printf;	.scl	3;	.type	32;	.endef
	.file	"toy.c"
	.section .rdata,"dr"
.globl _helloWorld
.globl _main

	.file	"toy2.c"
	.section .rdata,"dr"
.globl _goodbye
.globl _main

