	.file	"trackball_calibrator.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"FLOAT"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"SONiX Perixx Trackball Keyboard Mouse"
	.section	.rodata.str1.1
.LC2:
	.string	"libinput Accel Speed"
	.section	.rodata.str1.8
	.align 8
.LC4:
	.string	"libinput Accel Profile Enabled"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xor	edi, edi
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	call	XOpenDisplay
	test	rax, rax
	je	.L29
	mov	rbx, rax
	.p2align 4,,10
	.p2align 3
.L2:
	lea	rdx, [rsp+8]
	xor	esi, esi
	mov	rdi, rbx
	mov	DWORD PTR [rsp+8], 0
	call	XIQueryDevice
	mov	r13, rax
	test	rax, rax
	je	.L4
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC0
	mov	rdi, rbx
	mov	rbp, r13
	call	XInternAtom
	mov	r15d, DWORD PTR [rsp+8]
	xor	r12d, r12d
	mov	r14, rax
	test	r15d, r15d
	jg	.L9
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L8:
	mov	rdi, rbx
	call	XFlush
	mov	r15d, DWORD PTR [rsp+8]
.L6:
	add	r12d, 1
	add	rbp, 40
	cmp	r12d, r15d
	jge	.L10
.L9:
	mov	rdi, QWORD PTR [rbp+8]
	test	rdi, rdi
	je	.L6
	mov	esi, OFFSET FLAT:.LC1
	call	strstr
	test	rax, rax
	je	.L6
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC2
	mov	rdi, rbx
	mov	r15d, DWORD PTR [rbp+0]
	call	XInternAtom
	test	rax, rax
	je	.L7
	test	r14, r14
	je	.L7
	mov	r8d, 32
	mov	rdi, rbx
	xor	r9d, r9d
	mov	rdx, rax
	mov	DWORD PTR [rsp+12], 0xbf800000
	mov	esi, r15d
	push	1
	.cfi_def_cfa_offset 88
	lea	rcx, [rsp+20]
	push	rcx
	.cfi_def_cfa_offset 96
	mov	rcx, r14
	call	XIChangeProperty
	pop	rdi
	.cfi_def_cfa_offset 88
	pop	r8
	.cfi_def_cfa_offset 80
.L7:
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC4
	mov	rdi, rbx
	call	XInternAtom
	test	rax, rax
	je	.L8
	mov	edx, 1
	mov	esi, r15d
	xor	r9d, r9d
	mov	rdi, rbx
	mov	WORD PTR [rsp+12], dx
	mov	r8d, 8
	mov	rdx, rax
	push	2
	.cfi_def_cfa_offset 88
	lea	rcx, [rsp+20]
	push	rcx
	.cfi_def_cfa_offset 96
	mov	ecx, 19
	call	XIChangeProperty
	pop	rcx
	.cfi_def_cfa_offset 88
	pop	rsi
	.cfi_def_cfa_offset 80
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L10:
	mov	rdi, r13
	call	XIFreeDeviceInfo
.L4:
	mov	edi, 1
	call	sleep
	jmp	.L2
.L29:
	add	rsp, 24
	.cfi_def_cfa_offset 56
	mov	eax, 1
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
