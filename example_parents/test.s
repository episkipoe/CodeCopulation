	.file	"test.c"
	.section .rdata,"dr"
LC0:
	.ascii "idx is %i\12\0"
	.text
.globl _outputIdx
	.def	_outputIdx;	.scl	2;	.type	32;	.endef
_outputIdx:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_printf
	leave
	ret
	.section .rdata,"dr"
LC1:
	.ascii "val is %i\12\0"
	.text
.globl _outputVal
	.def	_outputVal;	.scl	2;	.type	32;	.endef
_outputVal:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_printf
	leave
	ret
.globl _chooseAllele
	.def	_chooseAllele;	.scl	2;	.type	32;	.endef
_chooseAllele:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$0, (%esp)
	call	_time
	movl	%eax, (%esp)
	call	_srand
	call	_rand
	movl	%eax, -4(%ebp)
	movl	$1374389535, %eax
	imull	-4(%ebp)
	sarl	$5, %edx
	movl	-4(%ebp), %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	addl	%edx, %eax
	sall	$2, %eax
	movl	-4(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	cmpl	8(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
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
	movl	$10, (%esp)
	call	_chooseAllele
	testl	%eax, %eax
	je	L5
	movl	$10, (%esp)
	call	_outputIdx
	jmp	L6
L5:
	movl	$0, (%esp)
	call	_outputVal
L6:
	movl	$90, (%esp)
	call	_chooseAllele
	testl	%eax, %eax
	je	L7
	movl	$90, (%esp)
	call	_outputIdx
	jmp	L8
L7:
	movl	$0, (%esp)
	call	_outputVal
L8:
	movl	$0, (%esp)
	call	_exit
	.def	_exit;	.scl	3;	.type	32;	.endef
	.def	_rand;	.scl	3;	.type	32;	.endef
	.def	_time;	.scl	3;	.type	32;	.endef
	.def	_srand;	.scl	3;	.type	32;	.endef
	.def	_printf;	.scl	3;	.type	32;	.endef
