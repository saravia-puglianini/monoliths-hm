	.file	"type_move.c"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.type	mouse_click, @function
mouse_click:
.LFB25:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xor	ecx, ecx
	mov	edx, 1
	mov	ebp, esi
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	mov	rbx, rdi
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	mov	edi, 1000
	call	usleep
	mov	rdi, rbx
	mov	esi, ebp
	xor	ecx, ecx
	xor	edx, edx
	call	XTestFakeButtonEvent
	add	rsp, 8
	.cfi_def_cfa_offset 24
	mov	rdi, rbx
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	jmp	XFlush
	.cfi_endproc
.LFE25:
	.size	mouse_click, .-mouse_click
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Usage: %s <action> [args...]\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"type_move: Cannot open X Display\n"
	.section	.rodata.str1.1
.LC2:
	.string	"move"
.LC3:
	.string	"wrapper"
.LC4:
	.string	"click"
.LC5:
	.string	"click_repeat"
.LC6:
	.string	"mousedown"
.LC7:
	.string	"mouseup"
.LC8:
	.string	"release_all"
.LC9:
	.string	"drag_start"
.LC10:
	.string	"toggle_middle"
.LC11:
	.string	"ctrl_wheel"
.LC12:
	.string	"Unknown action: %s\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB26:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rsi
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	cmp	edi, 1
	jle	.L55
	mov	ebp, edi
	xor	edi, edi
	call	XOpenDisplay
	mov	rbx, rax
	test	rax, rax
	je	.L56
	mov	r13, QWORD PTR [r12+8]
	mov	esi, OFFSET FLAT:.LC2
	mov	rdi, r13
	call	strcmp
	mov	r14d, eax
	test	eax, eax
	jne	.L8
	cmp	ebp, 2
	jne	.L57
	mov	DWORD PTR [rsp+12], 0
	xor	r13d, r13d
	xor	r15d, r15d
.L11:
	lea	rsi, [rsp+16]
	mov	rdi, rbx
	call	XGetKeyboardControl
	mov	edx, DWORD PTR [rsp+32]
	mov	rdi, rbx
	and	edx, 1
	cmove	r13d, DWORD PTR [rsp+12]
	cmove	r15d, r14d
	xor	ecx, ecx
	mov	esi, r13d
	mov	edx, r15d
	call	XTestFakeRelativeMotionEvent
	mov	rdi, rbx
	call	XFlush
.L13:
	mov	rdi, rbx
	call	XCloseDisplay
	xor	eax, eax
.L4:
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L8:
	.cfi_restore_state
	mov	esi, OFFSET FLAT:.LC3
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L58
	mov	esi, OFFSET FLAT:.LC4
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	jne	.L16
	mov	esi, 1
	cmp	ebp, 2
	jne	.L59
.L17:
	mov	rdi, rbx
	call	mouse_click
	jmp	.L13
.L55:
	mov	rdx, QWORD PTR [rsi]
	mov	rdi, QWORD PTR stderr[rip]
	mov	esi, OFFSET FLAT:.LC0
	xor	eax, eax
	call	fprintf
	mov	eax, 1
	jmp	.L4
.L16:
	mov	esi, OFFSET FLAT:.LC5
	mov	rdi, r13
	call	strcmp
	mov	r14d, eax
	test	eax, eax
	jne	.L18
	cmp	ebp, 2
	jne	.L60
	mov	r13d, 4
	mov	ebp, 1
.L19:
	lea	r12d, [rbp-1]
	jmp	.L20
.L22:
	mov	esi, r13d
	mov	rdi, rbx
	call	mouse_click
	cmp	r12d, r14d
	jle	.L21
	mov	edi, 10000
	call	usleep
.L21:
	add	r14d, 1
.L20:
	cmp	r14d, ebp
	jl	.L22
	jmp	.L13
.L57:
	mov	rdi, QWORD PTR [r12+16]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	r13d, eax
	cmp	ebp, 3
	je	.L36
	mov	rdi, QWORD PTR [r12+24]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	r15d, eax
	cmp	ebp, 4
	jle	.L37
	mov	rdi, QWORD PTR [r12+32]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	DWORD PTR [rsp+12], eax
.L9:
	cmp	ebp, 5
	jle	.L11
	mov	rdi, QWORD PTR [r12+40]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	r14d, eax
	jmp	.L11
.L58:
	lea	rsi, [rsp+16]
	mov	rdi, rbx
	call	XGetKeyboardControl
	mov	eax, DWORD PTR [rsp+32]
	mov	rdi, rbx
	and	eax, 1
	cmp	eax, 1
	sbb	esi, esi
	and	esi, 24
	sub	esi, 32
	cmp	eax, 1
	sbb	edx, edx
	xor	ecx, ecx
	and	edx, -24
	add	edx, 32
	call	XTestFakeRelativeMotionEvent
	mov	rdi, rbx
	call	XFlush
	jmp	.L13
.L56:
	mov	edx, 33
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC1
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	mov	eax, 1
	jmp	.L4
.L18:
	mov	esi, OFFSET FLAT:.LC6
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L61
	mov	esi, OFFSET FLAT:.LC7
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	jne	.L26
	mov	esi, 1
	cmp	ebp, 2
	jne	.L62
.L27:
	mov	rdi, rbx
	xor	ecx, ecx
	xor	edx, edx
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	jmp	.L13
.L61:
	mov	esi, 1
	cmp	ebp, 2
	jne	.L63
.L25:
	mov	rdi, rbx
	xor	ecx, ecx
	mov	edx, 1
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	jmp	.L13
.L60:
	mov	rdi, QWORD PTR [r12+16]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	r13d, eax
	cmp	ebp, 3
	je	.L41
	mov	rdi, QWORD PTR [r12+24]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	ebp, eax
	jmp	.L19
.L59:
	mov	rdi, QWORD PTR [r12+16]
	xor	esi, esi
	mov	edx, 10
	call	strtol
	mov	esi, eax
	jmp	.L17
.L26:
	mov	esi, OFFSET FLAT:.LC8
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L64
	mov	esi, OFFSET FLAT:.LC9
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L65
	mov	esi, OFFSET FLAT:.LC10
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L66
	mov	esi, OFFSET FLAT:.LC11
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	jne	.L32
	mov	r13d, 4
	cmp	ebp, 2
	jne	.L67
.L33:
	mov	esi, 65507
	mov	rdi, rbx
	call	XKeysymToKeycode
	test	al, al
	je	.L68
.L34:
	movzx	ebp, al
	xor	ecx, ecx
	mov	edx, 1
	mov	rdi, rbx
	mov	esi, ebp
	call	XTestFakeKeyEvent
	mov	rdi, rbx
	call	XFlush
	mov	edi, 10000
	call	usleep
	mov	esi, r13d
	mov	rdi, rbx
	call	mouse_click
	mov	edi, 10000
	call	usleep
	mov	rdi, rbx
	xor	ecx, ecx
	xor	edx, edx
	mov	esi, ebp
	call	XTestFakeKeyEvent
	mov	rdi, rbx
	call	XFlush
	jmp	.L13
.L63:
	mov	rdi, QWORD PTR [r12+16]
	xor	esi, esi
	mov	edx, 10
	call	strtol
	mov	esi, eax
	jmp	.L25
.L62:
	mov	rdi, QWORD PTR [r12+16]
	xor	esi, esi
	mov	edx, 10
	call	strtol
	mov	esi, eax
	jmp	.L27
.L64:
	xor	ecx, ecx
	xor	edx, edx
	mov	esi, 1
	mov	rdi, rbx
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	xor	ecx, ecx
	xor	edx, edx
	mov	esi, 2
	mov	rdi, rbx
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	mov	rdi, rbx
	xor	ecx, ecx
	xor	edx, edx
	mov	esi, 3
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	jmp	.L13
.L65:
	mov	esi, 1
	mov	rdi, rbx
	call	mouse_click
	mov	edi, 50000
	call	usleep
	xor	ecx, ecx
	mov	edx, 1
	mov	rdi, rbx
	mov	esi, 1
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	mov	edi, 50000
	call	usleep
	mov	rdi, rbx
	xor	ecx, ecx
	xor	edx, edx
	mov	esi, 1
	call	XTestFakeRelativeMotionEvent
	mov	rdi, rbx
	call	XFlush
	jmp	.L13
.L68:
	mov	esi, 65508
	mov	rdi, rbx
	call	XKeysymToKeycode
	test	al, al
	je	.L13
	jmp	.L34
.L66:
	lea	rsi, [rsp+16]
	mov	rdi, rbx
	call	XGetKeyboardControl
	xor	ecx, ecx
	mov	edx, 1
	test	BYTE PTR [rsp+32], 1
	jne	.L54
	xor	edx, edx
.L54:
	mov	rdi, rbx
	mov	esi, 2
	call	XTestFakeButtonEvent
	mov	rdi, rbx
	call	XFlush
	jmp	.L13
.L67:
	mov	rdi, QWORD PTR [r12+16]
	mov	edx, 10
	xor	esi, esi
	call	strtol
	mov	r13d, eax
	jmp	.L33
.L32:
	mov	rdi, QWORD PTR stderr[rip]
	mov	rdx, r13
	mov	esi, OFFSET FLAT:.LC12
	xor	eax, eax
	call	fprintf
	mov	rdi, rbx
	call	XCloseDisplay
	mov	eax, 1
	jmp	.L4
.L36:
	xor	r15d, r15d
.L37:
	mov	DWORD PTR [rsp+12], 0
	jmp	.L9
.L41:
	mov	ebp, 1
	jmp	.L19
	.cfi_endproc
.LFE26:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
