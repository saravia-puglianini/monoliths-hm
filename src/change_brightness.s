	.file	"change_brightness.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"r"
.LC2:
	.string	"xrandr --verbose 2>/dev/null"
.LC3:
	.string	"brightness"
	.text
	.p2align 4,,15
	.type	get_current_brightness, @function
get_current_brightness:
.LFB23:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	esi, OFFSET FLAT:.LC1
	mov	edi, OFFSET FLAT:.LC2
	sub	rsp, 528
	.cfi_def_cfa_offset 544
	call	popen
	test	rax, rax
	je	.L6
	mov	rbx, rax
	.p2align 4,,10
	.p2align 3
.L9:
	mov	rdx, rbx
	mov	esi, 512
	lea	rdi, [rsp+16]
	call	fgets
	test	rax, rax
	je	.L14
	mov	esi, OFFSET FLAT:.LC3
	lea	rdi, [rsp+16]
	call	strcasestr
	test	rax, rax
	je	.L9
	mov	esi, 58
	lea	rdi, [rsp+16]
	call	strchr
	test	rax, rax
	je	.L9
	lea	rdi, [rax+1]
	xor	esi, esi
	call	strtod
.L4:
	mov	rdi, rbx
	movsd	QWORD PTR [rsp+8], xmm0
	call	pclose
	movsd	xmm0, QWORD PTR [rsp+8]
.L1:
	add	rsp, 528
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
.L14:
	.cfi_restore_state
	movsd	xmm0, QWORD PTR .LC0[rip]
	jmp	.L4
.L6:
	movsd	xmm0, QWORD PTR .LC0[rip]
	jmp	.L1
	.cfi_endproc
.LFE23:
	.size	get_current_brightness, .-get_current_brightness
	.section	.rodata.str1.1
.LC5:
	.string	"up"
.LC7:
	.string	"%.2f"
.LC8:
	.string	"--brightness"
.LC9:
	.string	"eDP-1"
.LC10:
	.string	"--output"
.LC11:
	.string	"xrandr"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	cmp	edi, 1
	jle	.L22
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	rbx, rsi
	sub	rsp, 64
	.cfi_def_cfa_offset 80
	call	get_current_brightness
	mov	rdi, QWORD PTR [rbx+8]
	mov	esi, OFFSET FLAT:.LC5
	movsd	QWORD PTR [rsp+8], xmm0
	call	strcmp
	movsd	xmm0, QWORD PTR [rsp+8]
	test	eax, eax
	je	.L29
	subsd	xmm0, QWORD PTR .LC6[rip]
	movsd	xmm1, QWORD PTR .LC4[rip]
	maxsd	xmm1, xmm0
	movapd	xmm0, xmm1
.L18:
	mov	edx, OFFSET FLAT:.LC7
	mov	esi, 32
	lea	rdi, [rsp+32]
	mov	eax, 1
	call	snprintf
	call	fork
	test	eax, eax
	je	.L30
	lea	rsi, [rsp+28]
	xor	edx, edx
	mov	edi, eax
	call	waitpid
	add	rsp, 64
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
.L29:
	.cfi_restore_state
	addsd	xmm0, QWORD PTR .LC6[rip]
	movsd	xmm1, QWORD PTR .LC0[rip]
	minsd	xmm1, xmm0
	movapd	xmm0, xmm1
	jmp	.L18
.L22:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	mov	eax, 1
	ret
.L30:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -16
	push	rdx
	.cfi_def_cfa_offset 88
	mov	esi, OFFSET FLAT:.LC11
	mov	r8d, OFFSET FLAT:.LC8
	mov	ecx, OFFSET FLAT:.LC9
	push	0
	.cfi_def_cfa_offset 96
	mov	rdi, rsi
	mov	edx, OFFSET FLAT:.LC10
	lea	r9, [rsp+48]
	call	execlp
	mov	edi, 1
	call	_exit
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	2576980378
	.long	1069128089
	.align 8
.LC6:
	.long	2576980378
	.long	1068079513
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
