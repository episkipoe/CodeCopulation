	.file	"mail.c"
	.section .rdata,"dr"
LC0:
	.ascii " \0"
	.text
.globl _getNumber
	.def	_getNumber;	.scl	2;	.type	32;	.endef
_getNumber:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$LC0, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strtok
	movl	%eax, -8(%ebp)
L2:
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	_strtok
	movl	%eax, -8(%ebp)
	cmpl	$0, -8(%ebp)
	jne	L5
	movl	$-2, -12(%ebp)
	jmp	L1
L5:
	movl	-8(%ebp), %eax
	movsbl	(%eax),%eax
	addl	__imp___ctype_, %eax
	incl	%eax
	movsbl	(%eax),%eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L6
	leal	12(%ebp), %eax
	decl	(%eax)
L6:
	movl	-8(%ebp), %eax
	cmpb	$42, (%eax)
	jne	L4
	movl	$-1, -12(%ebp)
	jmp	L1
L4:
	cmpl	$0, 12(%ebp)
	je	L3
	jmp	L2
L3:
	movl	-8(%ebp), %eax
	movl	%eax, (%esp)
	call	_atoi
	movl	%eax, -12(%ebp)
L1:
	movl	-12(%ebp), %eax
	leave
	ret
	.section .rdata,"dr"
LC1:
	.ascii "stat\12\0"
LC2:
	.ascii "You have No Messages\0"
LC3:
	.ascii "You have %i messages\12\0"
LC4:
	.ascii "Error!  Negative Messages: %i\0"
	.text
.globl _getNumberOfMessages
	.def	_getNumberOfMessages;	.scl	2;	.type	32;	.endef
_getNumberOfMessages:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$280, %esp
	movl	$LC1, 4(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	movl	$0, 12(%esp)
	movl	$6, 8(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movl	$1, 4(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	_getNumber
	movl	%eax, _msgs
	cmpl	$0, _msgs
	jne	L9
	movl	$LC2, (%esp)
	call	_printf
	jmp	L8
L9:
	cmpl	$0, _msgs
	jle	L11
	movl	_msgs, %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	jmp	L8
L11:
	movl	_msgs, %eax
	movl	%eax, 4(%esp)
	movl	$LC4, (%esp)
	call	_printf
L8:
	leave
	ret
	.section .rdata,"dr"
	.align 4
LC5:
	.ascii "Error: summarize %i Invalid Message\0"
LC6:
	.ascii "No Subject \0"
LC7:
	.ascii "Unknown Sender \0"
LC8:
	.ascii "retr %i\12\0"
LC9:
	.ascii "From:\0"
LC10:
	.ascii "Unknown\0"
LC11:
	.ascii "Subject:\0"
LC12:
	.ascii "No Subject\0"
	.align 4
LC13:
	.ascii "%i) %i bytes | From: %s | Subject %s\12\0"
	.text
.globl _summarize
	.def	_summarize;	.scl	2;	.type	32;	.endef
_summarize:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$872, %esp
	movl	$0, -284(%ebp)
	cmpl	$0, 8(%ebp)
	jle	L15
	movl	8(%ebp), %eax
	cmpl	_msgs, %eax
	jg	L15
	jmp	L14
L15:
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC5, (%esp)
	call	_printf
	jmp	L13
L14:
	movl	$LC6, 4(%esp)
	leal	-584(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	movl	$LC7, 4(%esp)
	leal	-840(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$LC8, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	incl	%eax
	movl	%eax, -316(%ebp)
	movl	$0, 12(%esp)
	movl	-316(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	leal	-9(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	cmpb	$43, -9(%ebp)
	je	L17
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	jmp	L13
L17:
	cmpb	$10, -9(%ebp)
	je	L18
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	leal	-9(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movsbl	-9(%ebp),%eax
	addl	__imp___ctype_, %eax
	incl	%eax
	movsbl	(%eax),%eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L17
	movl	-284(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	leal	-304(%eax), %edx
	movzbl	-9(%ebp), %eax
	movb	%al, (%edx)
	leal	-284(%ebp), %eax
	incl	(%eax)
	jmp	L17
L18:
	leal	-312(%ebp), %eax
	addl	-284(%ebp), %eax
	movb	$0, (%eax)
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_atoi
	movl	%eax, -316(%ebp)
	movl	-316(%ebp), %eax
	movl	%eax, -320(%ebp)
	leal	-316(%ebp), %eax
	addl	$5, (%eax)
L20:
	cmpl	$7, -316(%ebp)
	jle	L23
	movl	$0, 12(%esp)
	movl	$8, 8(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movl	%eax, %edx
	leal	-316(%ebp), %eax
	subl	%edx, (%eax)
L23:
	leal	-280(%ebp), %eax
	movl	$5, 8(%esp)
	movl	$LC9, 4(%esp)
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L24
	leal	-840(%ebp), %eax
	movl	$7, 8(%esp)
	movl	$LC10, 4(%esp)
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L24
	movl	$3, 8(%esp)
	leal	-840(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-280(%ebp), %eax
	addl	$5, %eax
	movl	%eax, (%esp)
	call	_bcopy
	movl	$3, -284(%ebp)
	movb	$0, -9(%ebp)
L25:
	cmpb	$10, -9(%ebp)
	je	L26
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	leal	-9(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movl	%eax, %edx
	leal	-316(%ebp), %eax
	subl	%edx, (%eax)
	movl	-284(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	leal	-832(%eax), %edx
	movzbl	-9(%ebp), %eax
	movb	%al, (%edx)
	leal	-284(%ebp), %eax
	incl	(%eax)
	jmp	L25
L26:
	leal	-842(%ebp), %eax
	addl	-284(%ebp), %eax
	movb	$0, (%eax)
	jmp	L22
L24:
	leal	-280(%ebp), %eax
	movl	$8, 8(%esp)
	movl	$LC11, 4(%esp)
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L28
	leal	-584(%ebp), %eax
	movl	$10, 8(%esp)
	movl	$LC12, 4(%esp)
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L28
	movl	$0, -284(%ebp)
	movb	$0, -9(%ebp)
L29:
	cmpb	$10, -9(%ebp)
	je	L30
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	leal	-9(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movl	%eax, %edx
	leal	-316(%ebp), %eax
	subl	%edx, (%eax)
	movl	-284(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	leal	-576(%eax), %edx
	movzbl	-9(%ebp), %eax
	movb	%al, (%edx)
	leal	-284(%ebp), %eax
	incl	(%eax)
	jmp	L29
L30:
	leal	-586(%ebp), %eax
	addl	-284(%ebp), %eax
	movb	$0, (%eax)
	jmp	L22
L28:
	movb	$0, -9(%ebp)
L32:
	cmpb	$10, -9(%ebp)
	je	L22
	cmpl	$0, -316(%ebp)
	jle	L22
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	leal	-9(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movl	%eax, %edx
	leal	-316(%ebp), %eax
	subl	%edx, (%eax)
	jmp	L32
L22:
	cmpl	$0, -316(%ebp)
	jle	L21
	jmp	L20
L21:
	leal	-584(%ebp), %eax
	movl	%eax, 16(%esp)
	leal	-840(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	-320(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC13, (%esp)
	call	_printf
L13:
	leave
	ret
.globl _doSummary
	.def	_doSummary;	.scl	2;	.type	32;	.endef
_doSummary:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$1, -4(%ebp)
L35:
	movl	-4(%ebp), %eax
	cmpl	_msgs, %eax
	jg	L34
	movl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_summarize
	leal	-4(%ebp), %eax
	incl	(%eax)
	jmp	L35
L34:
	leave
	ret
	.section .rdata,"dr"
LC14:
	.ascii "Could not retrieve Message\0"
	.text
.globl _doRetrieve
	.def	_doRetrieve;	.scl	2;	.type	32;	.endef
_doRetrieve:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$328, %esp
	movl	$0, -300(%ebp)
	cmpl	$-2, 8(%ebp)
	jg	L39
	jmp	L38
L39:
	cmpl	$-1, 8(%ebp)
	jne	L40
	movl	$1, -304(%ebp)
L41:
	movl	-304(%ebp), %eax
	cmpl	_msgs, %eax
	jg	L38
	movl	-304(%ebp), %eax
	movl	%eax, (%esp)
	call	_doRetrieve
	leal	-304(%ebp), %eax
	incl	(%eax)
	jmp	L41
L40:
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$LC8, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	incl	%eax
	movl	%eax, -304(%ebp)
	movl	$0, 12(%esp)
	movl	-304(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	leal	-9(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	cmpb	$43, -9(%ebp)
	je	L45
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC14, (%esp)
	call	_fputs
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	jmp	L38
L45:
	cmpb	$10, -9(%ebp)
	je	L46
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	leal	-9(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movsbl	-9(%ebp),%eax
	addl	__imp___ctype_, %eax
	incl	%eax
	movsbl	(%eax),%eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L45
	movl	-300(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	leal	-288(%eax), %edx
	movzbl	-9(%ebp), %eax
	movb	%al, (%edx)
	leal	-300(%ebp), %eax
	incl	(%eax)
	jmp	L45
L46:
	leal	-296(%ebp), %eax
	addl	-300(%ebp), %eax
	movb	$0, (%eax)
	leal	-296(%ebp), %eax
	movl	%eax, (%esp)
	call	_atoi
	movl	%eax, -304(%ebp)
	leal	-304(%ebp), %eax
	addl	$5, (%eax)
L48:
	cmpl	$0, -304(%ebp)
	jle	L38
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movl	%eax, -300(%ebp)
	leal	-280(%ebp), %eax
	addl	-300(%ebp), %eax
	movb	$0, (%eax)
	movl	-300(%ebp), %edx
	leal	-304(%ebp), %eax
	subl	%edx, (%eax)
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	_fputs
	jmp	L48
L38:
	leave
	ret
	.section .rdata,"dr"
LC15:
	.ascii "dele %i\12\0"
	.align 4
LC16:
	.ascii "Message %i marked for deletion \12\0"
	.align 4
LC17:
	.ascii "Unable to delete message %i (Possibly already deleted) \12\0"
	.text
.globl _doDelete
	.def	_doDelete;	.scl	2;	.type	32;	.endef
_doDelete:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$296, %esp
	cmpl	$-2, 8(%ebp)
	jg	L51
	jmp	L50
L51:
	cmpl	$-1, 8(%ebp)
	jne	L52
	movl	$1, -268(%ebp)
L53:
	movl	-268(%ebp), %eax
	cmpl	_msgs, %eax
	jg	L50
	movl	-268(%ebp), %eax
	movl	%eax, (%esp)
	call	_doDelete
	leal	-268(%ebp), %eax
	incl	(%eax)
	jmp	L53
L52:
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$LC15, 4(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	incl	%eax
	movl	%eax, -272(%ebp)
	movl	$0, 12(%esp)
	movl	-272(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	cmpb	$43, -264(%ebp)
	jne	L56
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC16, (%esp)
	call	_printf
	jmp	L50
L56:
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC17, (%esp)
	call	_printf
L50:
	leave
	ret
	.section .rdata,"dr"
	.align 4
LC18:
	.ascii "Sorry, Invalid Number!  %i is not between 1 and %i\12\0"
	.text
.globl _getMsgNumber
	.def	_getMsgNumber;	.scl	2;	.type	32;	.endef
_getMsgNumber:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$1, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_getNumber
	movl	%eax, -4(%ebp)
	cmpl	$-1, -4(%ebp)
	je	L59
	movl	-4(%ebp), %eax
	cmpl	_msgs, %eax
	jg	L60
	cmpl	$0, -4(%ebp)
	jle	L60
	jmp	L59
L60:
	movl	_msgs, %eax
	movl	%eax, 8(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC18, (%esp)
	call	_printf
	movl	$-2, -8(%ebp)
	jmp	L58
L59:
	movl	-4(%ebp), %eax
	movl	%eax, -8(%ebp)
L58:
	movl	-8(%ebp), %eax
	leave
	ret
	.section .rdata,"dr"
LC19:
	.ascii "quit\0"
LC20:
	.ascii "bye\0"
LC21:
	.ascii "quit\12\0"
	.align 4
LC22:
	.ascii "Invalid Exit:  Information may be left in buffer\12\0"
LC23:
	.ascii "summary\0"
LC24:
	.ascii "retrieve\0"
LC25:
	.ascii "delete\0"
LC26:
	.ascii "reset\0"
LC27:
	.ascii "rset\12\0"
LC28:
	.ascii "OK!\0"
LC29:
	.ascii "Error\0"
	.align 4
LC30:
	.ascii "Invalid Command \12 Valid commands: summary retrieve delete quit\0"
	.text
.globl _parseCmd
	.def	_parseCmd;	.scl	2;	.type	32;	.endef
_parseCmd:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$296, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, 8(%esp)
	movl	$LC19, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	je	L63
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, 8(%esp)
	movl	$LC20, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L62
L63:
	movl	$LC21, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	movl	$0, 12(%esp)
	movl	$6, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	cmpb	$43, -264(%ebp)
	je	L64
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC22, (%esp)
	call	_fputs
L64:
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	movl	$0, (%esp)
	call	_exit
L62:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, 8(%esp)
	movl	$LC23, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L66
	call	_doSummary
	jmp	L61
L66:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, 8(%esp)
	movl	$LC24, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L68
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_getMsgNumber
	movl	%eax, -268(%ebp)
	cmpl	$-2, -268(%ebp)
	je	L61
	movl	-268(%ebp), %eax
	movl	%eax, (%esp)
	call	_doRetrieve
	jmp	L61
L68:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, 8(%esp)
	movl	$LC25, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L71
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_getMsgNumber
	movl	%eax, -268(%ebp)
	cmpl	$-2, -268(%ebp)
	je	L61
	movl	-268(%ebp), %eax
	movl	%eax, (%esp)
	call	_doDelete
	jmp	L61
L71:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, 8(%esp)
	movl	$LC26, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncmp
	testl	%eax, %eax
	jne	L65
	movl	$LC27, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	movl	$0, 12(%esp)
	movl	$6, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	cmpb	$43, -264(%ebp)
	jne	L75
	movl	$LC28, (%esp)
	call	_printf
	jmp	L61
L75:
	movl	$LC29, (%esp)
	call	_printf
	jmp	L61
L65:
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC30, (%esp)
	call	_fputs
L61:
	leave
	ret
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC31:
	.ascii "banyan.partek.com\0"
LC32:
	.ascii "mail: socket\0"
LC33:
	.ascii "mail: connect\0"
LC34:
	.ascii "Enter Username: \0"
LC35:
	.ascii "Enter Password: \0"
LC36:
	.ascii "stty -echo\0"
LC37:
	.ascii "stty echo\0"
LC38:
	.ascii "user %s\0"
LC39:
	.ascii "pass %s\0"
	.align 4
LC40:
	.ascii "\12Invalid Username/Password.  Try Again? (Y/N)\0"
LC41:
	.ascii "\12\0"
LC42:
	.ascii "cmd=> \0"
LC43:
	.ascii "\12cmd=> \0"
	.text
.globl _main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$872, %esp
	andl	$-16, %esp
	movl	$0, %eax
	addl	$15, %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	movl	%eax, -844(%ebp)
	movl	-844(%ebp), %eax
	call	__alloca
	call	___main
	movw	$0, -826(%ebp)
	cmpl	$2, 8(%ebp)
	jne	L78
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)
	jmp	L79
L78:
	movl	$LC31, -44(%ebp)
L79:
	movl	-44(%ebp), %eax
	movl	%eax, (%esp)
	call	_gethostbyname
	movl	%eax, -16(%ebp)
	movl	$16, 4(%esp)
	leal	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_bzero
	movw	$2, -40(%ebp)
	movl	-16(%ebp), %eax
	movswl	10(%eax),%eax
	movl	%eax, 8(%esp)
	leal	-40(%ebp), %eax
	addl	$4, %eax
	movl	%eax, 4(%esp)
	movl	-16(%ebp), %eax
	movl	12(%eax), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_bcopy
	movl	$110, (%esp)
	call	_htons
	movw	%ax, -38(%ebp)
	movl	$0, 8(%esp)
	movl	$1, 4(%esp)
	movl	$2, (%esp)
	call	_socket
	movl	%eax, _s
	cmpl	$0, _s
	jns	L80
	movl	$LC32, (%esp)
	call	_perror
	movl	$1, (%esp)
	call	_exit
L80:
	movl	$16, 8(%esp)
	leal	-40(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_connect
	testl	%eax, %eax
	jns	L81
	movl	$LC33, (%esp)
	call	_perror
	movl	$1, (%esp)
	call	_exit
L81:
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
L82:
	cmpw	$0, -826(%ebp)
	jne	L83
	movl	$LC34, (%esp)
	call	_puts
	call	___getreent
	movl	4(%eax), %eax
	movl	%eax, 8(%esp)
	movl	$256, 4(%esp)
	leal	-568(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgets
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC35, (%esp)
	call	_fputs
	movl	$LC36, (%esp)
	call	_system
	call	___getreent
	movl	4(%eax), %eax
	movl	%eax, 8(%esp)
	movl	$256, 4(%esp)
	leal	-824(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgets
	movl	$LC37, (%esp)
	call	_system
	leal	-568(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$LC38, 4(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	incl	%eax
	movl	%eax, -832(%ebp)
	movl	$0, 12(%esp)
	movl	-832(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	leal	-824(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$LC39, 4(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	incl	%eax
	movl	%eax, -832(%ebp)
	movl	$0, 12(%esp)
	movl	-832(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_send
	movl	$0, 12(%esp)
	movl	$256, 8(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	_s, %eax
	movl	%eax, (%esp)
	call	_recv
	cmpb	$45, -312(%ebp)
	jne	L84
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC40, (%esp)
	call	_fputs
	call	___getreent
	movl	4(%eax), %eax
	movl	%eax, 8(%esp)
	movl	$4, 4(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgets
	movsbl	-312(%ebp),%eax
	movl	%eax, -836(%ebp)
	movl	-836(%ebp), %eax
	movl	%eax, -840(%ebp)
	movl	-836(%ebp), %eax
	addl	__imp___ctype_, %eax
	incl	%eax
	movsbl	(%eax),%eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L86
	subl	$32, -840(%ebp)
L86:
	cmpl	$78, -840(%ebp)
	jne	L82
	movl	$1, (%esp)
	call	_exit
L84:
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC41, (%esp)
	call	_fputs
	movw	$1, -826(%ebp)
	jmp	L82
L83:
	call	_getNumberOfMessages
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC42, (%esp)
	call	_fputs
L88:
	call	___getreent
	movl	4(%eax), %eax
	movl	%eax, 8(%esp)
	movl	$256, 4(%esp)
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgets
	testl	%eax, %eax
	je	L89
	movb	$0, -57(%ebp)
	leal	-312(%ebp), %eax
	movl	%eax, (%esp)
	call	_parseCmd
	call	___getreent
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC43, (%esp)
	call	_fputs
	jmp	L88
L89:
	movl	$1, %eax
	leave
	ret
	.comm	_s, 16	 # 4
	.comm	_msgs, 16	 # 4
	.def	_system;	.scl	3;	.type	32;	.endef
	.def	_fgets;	.scl	3;	.type	32;	.endef
	.def	_puts;	.scl	3;	.type	32;	.endef
	.def	_connect;	.scl	3;	.type	32;	.endef
	.def	_perror;	.scl	3;	.type	32;	.endef
	.def	_socket;	.scl	3;	.type	32;	.endef
	.def	_htons;	.scl	3;	.type	32;	.endef
	.def	_bzero;	.scl	3;	.type	32;	.endef
	.def	_gethostbyname;	.scl	3;	.type	32;	.endef
	.def	_exit;	.scl	3;	.type	32;	.endef
	.def	___getreent;	.scl	3;	.type	32;	.endef
	.def	_fputs;	.scl	3;	.type	32;	.endef
	.def	_bcopy;	.scl	3;	.type	32;	.endef
	.def	_strncmp;	.scl	3;	.type	32;	.endef
	.def	_strlen;	.scl	3;	.type	32;	.endef
	.def	_printf;	.scl	3;	.type	32;	.endef
	.def	_recv;	.scl	3;	.type	32;	.endef
	.def	_send;	.scl	3;	.type	32;	.endef
	.def	_sprintf;	.scl	3;	.type	32;	.endef
	.def	_atoi;	.scl	3;	.type	32;	.endef
	.def	_strtok;	.scl	3;	.type	32;	.endef
