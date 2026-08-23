	.file	"simple_timer.c"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.type	handle_sig, @function
handle_sig:
.LFB22:
	.cfi_startproc
	mov	DWORD PTR keep_running[rip], 0
	ret
	.cfi_endproc
.LFE22:
	.size	handle_sig, .-handle_sig
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"\r\033[K[Temporizador] %02d:%02d (%d s restantes)"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"\n\302\241Tiempo finalizado!"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	cmp	edi, 1
	jg	.L4
.L6:
	mov	ebx, 60
.L5:
	mov	esi, OFFSET FLAT:handle_sig
	mov	edi, 2
	mov	ebp, -2004318071
	call	signal
	mov	esi, OFFSET FLAT:handle_sig
	mov	edi, 15
	call	signal
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L13:
	mov	edi, 1
	sub	ebx, 1
	call	sleep
.L7:
	mov	eax, DWORD PTR keep_running[rip]
	test	eax, eax
	je	.L10
	mov	eax, ebx
	mov	edi, OFFSET FLAT:.LC0
	mov	ecx, ebx
	mul	ebp
	mov	esi, edx
	mov	edx, ebx
	shr	esi, 5
	imul	eax, esi, 60
	sub	edx, eax
	xor	eax, eax
	call	printf
	mov	rdi, QWORD PTR stdout[rip]
	call	fflush
	test	ebx, ebx
	jne	.L13
.L10:
	mov	edi, OFFSET FLAT:.LC1
	call	puts
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
.L4:
	.cfi_restore_state
	mov	rdi, QWORD PTR [rsi+8]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	ebx, eax
	test	eax, eax
	jg	.L5
	jmp	.L6
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.data
	.align 4
	.type	keep_running, @object
	.size	keep_running, 4
keep_running:
	.long	1
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
