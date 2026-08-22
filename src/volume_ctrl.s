	.file	"volume_ctrl.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"amixer sget Master 2>/dev/null || amixer sget PCM 2>/dev/null"
	.section	.rodata.str1.1
.LC2:
	.string	"100%"
.LC3:
	.string	"Playback"
	.text
	.p2align 4,,15
	.type	print_current_volume, @function
print_current_volume:
.LFB24:
	.cfi_startproc
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, OFFSET FLAT:.LC1
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	sub	rsp, 288
	.cfi_def_cfa_offset 320
	call	popen
	test	rax, rax
	je	.L18
	mov	QWORD PTR [rsp], 623915057
	pxor	xmm0, xmm0
	mov	rbp, rax
	mov	QWORD PTR [rsp+8], 0
	movaps	XMMWORD PTR [rsp+16], xmm0
	.p2align 4,,10
	.p2align 3
.L11:
	mov	rdx, rbp
	mov	esi, 256
	lea	rdi, [rsp+32]
	call	fgets
	test	rax, rax
	je	.L19
	mov	esi, OFFSET FLAT:.LC3
	lea	rdi, [rsp+32]
	call	strstr
	test	rax, rax
	je	.L11
	mov	esi, 37
	lea	rdi, [rsp+32]
	call	strchr
	test	rax, rax
	je	.L11
	mov	esi, 91
	lea	rdi, [rsp+32]
	call	strchr
	mov	r12, rax
	test	rax, rax
	je	.L11
	mov	esi, 93
	mov	rdi, rax
	call	strchr
	test	rax, rax
	je	.L11
	sub	rax, r12
	lea	rbx, [rax-1]
	cmp	rbx, 31
	ja	.L11
	lea	rsi, [r12+1]
	mov	r12, rsp
	mov	rdx, rbx
	mov	rdi, r12
	call	strncpy
	mov	BYTE PTR [rsp+rbx], 0
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L19:
	mov	r12, rsp
.L5:
	mov	rdi, rbp
	call	pclose
	mov	rdi, r12
	call	puts
.L1:
	add	rsp, 288
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	mov	edi, OFFSET FLAT:.LC2
	call	puts
	jmp	.L1
	.cfi_endproc
.LFE24:
	.size	print_current_volume, .-print_current_volume
	.section	.rodata.str1.1
.LC4:
	.string	"Master"
.LC5:
	.string	"set"
.LC6:
	.string	"amixer"
.LC7:
	.string	"PCM"
	.text
	.p2align 4,,15
	.type	run_amixer_set, @function
run_amixer_set:
.LFB23:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	rbx, rdi
	sub	rsp, 16
	.cfi_def_cfa_offset 32
	call	fork
	test	eax, eax
	je	.L25
	xor	edx, edx
	lea	rsi, [rsp+12]
	mov	edi, eax
	call	waitpid
	call	fork
	test	eax, eax
	je	.L26
	lea	rsi, [rsp+12]
	xor	edx, edx
	mov	edi, eax
	call	waitpid
	add	rsp, 16
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
.L25:
	.cfi_restore_state
	xor	r9d, r9d
	mov	r8, rbx
	mov	ecx, OFFSET FLAT:.LC4
.L24:
	mov	esi, OFFSET FLAT:.LC6
	mov	edx, OFFSET FLAT:.LC5
	mov	rdi, rsi
	call	execlp
	mov	edi, 1
	call	_exit
.L26:
	xor	r9d, r9d
	mov	r8, rbx
	mov	ecx, OFFSET FLAT:.LC7
	jmp	.L24
	.cfi_endproc
.LFE23:
	.size	run_amixer_set, .-run_amixer_set
	.section	.rodata.str1.1
.LC8:
	.string	"up"
.LC9:
	.string	"raise"
.LC10:
	.string	"5+"
.LC11:
	.string	"down"
.LC12:
	.string	"lower"
.LC13:
	.string	"5-"
.LC14:
	.string	"get"
.LC15:
	.string	"actual"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB25:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	cmp	edi, 1
	jle	.L34
	mov	rbx, QWORD PTR [rsi+8]
	mov	edi, OFFSET FLAT:.LC8
	mov	ecx, 3
	mov	rsi, rbx
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	je	.L30
	mov	esi, OFFSET FLAT:.LC9
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	jne	.L54
.L30:
	mov	edi, OFFSET FLAT:.LC10
	call	run_amixer_set
.L29:
	xor	eax, eax
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L54:
	.cfi_restore_state
	mov	esi, OFFSET FLAT:.LC10
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L30
	mov	esi, OFFSET FLAT:.LC11
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L32
	mov	esi, OFFSET FLAT:.LC12
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L32
	mov	esi, OFFSET FLAT:.LC13
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L32
	mov	esi, OFFSET FLAT:.LC14
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L34
	mov	esi, OFFSET FLAT:.LC15
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L34
	mov	rdi, rbx
	call	run_amixer_set
	jmp	.L29
.L32:
	mov	edi, OFFSET FLAT:.LC13
	call	run_amixer_set
	jmp	.L29
.L34:
	call	print_current_volume
	jmp	.L29
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
