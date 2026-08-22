	.file	"personal_osdx.c"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.type	read_sysfs_int, @function
read_sysfs_int:
.LFB23:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xor	esi, esi
	xor	eax, eax
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 40
	.cfi_def_cfa_offset 64
	call	open
	test	eax, eax
	js	.L4
	mov	edi, eax
	mov	edx, 31
	mov	rsi, rsp
	mov	ebx, eax
	call	read
	mov	edi, ebx
	mov	rbp, rax
	call	close
	test	rbp, rbp
	jle	.L4
	mov	edx, 10
	xor	esi, esi
	mov	rdi, rsp
	mov	BYTE PTR [rsp+rbp], 0
	call	strtol
	jmp	.L1
.L4:
	xor	eax, eax
.L1:
	add	rsp, 40
	.cfi_def_cfa_offset 24
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	read_sysfs_int, .-read_sysfs_int
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"/home/user"
.LC1:
	.string	"[\342\226\210\342\226\210\342\226\210]"
.LC2:
	.string	"\342\232\241"
.LC3:
	.string	"[\342\226\210\342\226\221\342\226\221]"
.LC4:
	.string	"[\342\226\210\342\226\210\342\226\221]"
.LC5:
	.string	"[\342\226\221\342\226\221\342\226\221]"
.LC6:
	.string	"p.m."
.LC7:
	.string	"a.m."
.LC8:
	.string	"orange"
.LC9:
	.string	"Mouse quit Alt+1"
.LC10:
	.string	"green"
.LC11:
	.string	"Keyboard quit Alt+2"
.LC12:
	.string	"red"
.LC13:
	.string	"Xephyr quit Ctrl+Shift"
.LC14:
	.string	"HOME"
.LC15:
	.string	"%s/.big_hour"
.LC16:
	.string	"%s/.xbindkeysrc"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC17:
	.string	"/sys/class/power_supply/BAT0/capacity"
	.align 8
.LC18:
	.string	"/sys/class/power_supply/ADP1/online"
	.section	.rodata.str1.1
.LC19:
	.string	"%s %d%%  %02d:%02d %s"
.LC20:
	.string	"_NET_CLIENT_LIST"
.LC21:
	.string	"ctrl+shift releases"
.LC22:
	.string	"NOT MOUSE"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB26:
	.cfi_startproc
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	mov	edi, OFFSET FLAT:.LC14
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	mov	r12d, OFFSET FLAT:.LC2
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	sub	rsp, 4848
	.cfi_def_cfa_offset 4896
	call	getenv
	mov	edx, OFFSET FLAT:.LC15
	mov	esi, 256
	lea	rdi, [rsp+240]
	test	rax, rax
	mov	rbx, rax
	mov	eax, OFFSET FLAT:.LC0
	cmove	rbx, rax
	xor	eax, eax
	mov	rcx, rbx
	call	snprintf
	mov	rcx, rbx
	mov	edx, OFFSET FLAT:.LC16
	xor	eax, eax
	mov	esi, 256
	lea	rdi, [rsp+496]
	call	snprintf
	mov	edi, OFFSET FLAT:.LC17
	call	read_sysfs_int
	mov	edi, OFFSET FLAT:.LC18
	mov	ebp, eax
	call	read_sysfs_int
	cmp	eax, 1
	je	.L9
	mov	r12d, OFFSET FLAT:.LC1
	cmp	ebp, 84
	jle	.L71
.L9:
	xor	edi, edi
	mov	r13d, OFFSET FLAT:.LC6
	call	time
	lea	rsi, [rsp+48]
	lea	rdi, [rsp+8]
	mov	QWORD PTR [rsp+8], rax
	call	localtime_r
	mov	ecx, DWORD PTR [rsp+56]
	mov	edx, 715827883
	lea	rdi, [rsp+128]
	pxor	xmm0, xmm0
	mov	eax, ecx
	mov	ebx, ecx
	movaps	XMMWORD PTR [rsp+112], xmm0
	imul	edx
	mov	eax, ecx
	sar	eax, 31
	sar	edx
	sub	edx, eax
	lea	eax, [rdx+rdx*2]
	sal	eax, 2
	sub	ebx, eax
	mov	eax, 12
	cmove	ebx, eax
	cmp	ecx, 11
	mov	eax, OFFSET FLAT:.LC7
	mov	ecx, 14
	cmovle	r13, rax
	xor	eax, eax
	xor	esi, esi
	rep stosq
	lea	rdi, [rsp+240]
	call	access
	test	eax, eax
	jne	.L72
.L12:
	xor	edi, edi
	call	XOpenDisplay
	mov	rbp, rax
	test	rax, rax
	je	.L13
	movsx	rax, DWORD PTR [rax+224]
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC20
	mov	rdi, rbp
	sal	rax, 7
	add	rax, QWORD PTR [rbp+232]
	mov	rbx, QWORD PTR [rax+16]
	call	XInternAtom
	test	rax, rax
	jne	.L73
.L15:
	xor	esi, esi
	lea	rdi, [rsp+496]
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L37
	lea	r13, [rsp+752]
	mov	edi, eax
	mov	edx, 4095
	mov	rsi, r13
	call	read
	mov	edi, ebx
	mov	r12, rax
	call	close
	test	r12, r12
	jle	.L39
	xor	ebx, ebx
.L41:
	mov	esi, OFFSET FLAT:.LC22
	mov	rdi, r13
	mov	BYTE PTR [rsp+752+r12], 0
	call	strstr
	test	ebx, ebx
	je	.L35
.L23:
	mov	edi, 4
	call	xosd_create
	mov	rbx, rax
	test	rax, rax
	je	.L33
	mov	r14d, OFFSET FLAT:.LC12
	mov	r12d, OFFSET FLAT:.LC13
.L29:
	xor	esi, esi
	mov	rdi, rbx
	call	xosd_set_pos
	mov	esi, 2
	mov	rdi, rbx
	call	xosd_set_align
	mov	esi, 50
	mov	rdi, rbx
	call	xosd_set_horizontal_offset
	mov	esi, 1
	mov	rdi, rbx
	call	xosd_set_shadow_offset
	mov	esi, 1
	mov	rdi, rbx
	call	xosd_set_timeout
	mov	rsi, r14
	mov	rdi, rbx
	call	xosd_set_colour
	lea	rcx, [rsp+112]
	mov	rdi, rbx
	xor	eax, eax
	mov	edx, 1
	mov	esi, 2
	call	xosd_display
	mov	rcx, r12
	mov	edx, 1
	mov	rdi, rbx
	mov	esi, 3
	xor	eax, eax
	call	xosd_display
	mov	rdi, rbx
	call	xosd_wait_until_no_display
	mov	rdi, rbx
	call	xosd_destroy
.L27:
	test	rbp, rbp
	je	.L67
.L33:
	mov	rdi, rbp
	call	XCloseDisplay
.L67:
	add	rsp, 4848
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L71:
	.cfi_restore_state
	mov	r12d, OFFSET FLAT:.LC4
	cmp	ebp, 39
	jg	.L9
	cmp	ebp, 14
	mov	r12d, OFFSET FLAT:.LC3
	mov	eax, OFFSET FLAT:.LC5
	cmovle	r12, rax
	jmp	.L9
.L73:
	lea	rdx, [rsp+40]
	xor	r9d, r9d
	mov	r8d, 1024
	xor	ecx, ecx
	mov	QWORD PTR [rsp+40], 0
	mov	rsi, rbx
	mov	rdi, rbp
	push	rdx
	.cfi_def_cfa_offset 4904
	lea	rdx, [rsp+40]
	push	rdx
	.cfi_def_cfa_offset 4912
	lea	rdx, [rsp+40]
	push	rdx
	.cfi_def_cfa_offset 4920
	lea	rdx, [rsp+28]
	push	rdx
	.cfi_def_cfa_offset 4928
	lea	rdx, [rsp+48]
	push	rdx
	.cfi_def_cfa_offset 4936
	mov	rdx, rax
	push	33
	.cfi_def_cfa_offset 4944
	call	XGetWindowProperty
	add	rsp, 48
	.cfi_def_cfa_offset 4896
	test	eax, eax
	jne	.L15
	mov	r14, QWORD PTR [rsp+40]
	test	r14, r14
	je	.L15
	cmp	QWORD PTR [rsp+24], 0
	je	.L17
	xor	ebx, ebx
	lea	r13, [rsp+752]
	.p2align 4,,10
	.p2align 3
.L22:
	mov	rsi, QWORD PTR [r14+rbx*8]
	mov	rdx, r13
	mov	rdi, rbp
	mov	QWORD PTR [rsp+752], 0
	call	XFetchName
	test	eax, eax
	jle	.L18
	mov	r12, QWORD PTR [rsp+752]
	test	r12, r12
	je	.L18
	mov	rdi, r12
	mov	esi, OFFSET FLAT:.LC21
	call	strstr
	mov	rdi, r12
	test	rax, rax
	jne	.L74
	call	XFree
.L18:
	add	rbx, 1
	cmp	rbx, QWORD PTR [rsp+24]
	jb	.L22
	mov	r14, QWORD PTR [rsp+40]
.L17:
	mov	rdi, r14
	call	XFree
	jmp	.L15
.L13:
	xor	esi, esi
	lea	rdi, [rsp+496]
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L34
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+752]
	call	read
	mov	edi, ebx
	mov	r12, rax
	call	close
	test	r12, r12
	jle	.L34
	mov	esi, OFFSET FLAT:.LC22
	lea	rdi, [rsp+752]
	mov	BYTE PTR [rsp+752+r12], 0
	call	strstr
.L35:
	mov	r14d, OFFSET FLAT:.LC10
	mov	r12d, OFFSET FLAT:.LC11
	test	rax, rax
	je	.L39
.L24:
	mov	edi, 4
	call	xosd_create
	mov	rbx, rax
	test	rax, rax
	jne	.L29
	jmp	.L27
.L34:
	mov	edi, 4
	call	xosd_create
	mov	rbx, rax
	test	rax, rax
	je	.L67
	mov	r14d, OFFSET FLAT:.LC8
	mov	r12d, OFFSET FLAT:.LC9
	jmp	.L29
.L72:
	push	r13
	.cfi_def_cfa_offset 4904
	mov	eax, DWORD PTR [rsp+60]
	mov	edx, OFFSET FLAT:.LC19
	mov	r9d, ebx
	mov	r8d, ebp
	mov	rcx, r12
	mov	esi, 128
	push	rax
	.cfi_def_cfa_offset 4912
	xor	eax, eax
	lea	rdi, [rsp+128]
	call	snprintf
	pop	rax
	.cfi_def_cfa_offset 4904
	pop	rdx
	.cfi_def_cfa_offset 4896
	jmp	.L12
.L37:
	mov	r14d, OFFSET FLAT:.LC8
	mov	r12d, OFFSET FLAT:.LC9
.L36:
	mov	edi, 4
	call	xosd_create
	mov	rbx, rax
	test	rax, rax
	jne	.L29
	jmp	.L33
.L74:
	call	XFree
	mov	rdi, QWORD PTR [rsp+40]
	mov	r14d, OFFSET FLAT:.LC12
	mov	r12d, OFFSET FLAT:.LC13
	call	XFree
	xor	esi, esi
	lea	rdi, [rsp+496]
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L36
	mov	edi, eax
	mov	edx, 4095
	mov	rsi, r13
	call	read
	mov	edi, ebx
	mov	r12, rax
	call	close
	test	r12, r12
	jle	.L23
	mov	ebx, 1
	jmp	.L41
.L39:
	mov	r14d, OFFSET FLAT:.LC8
	mov	r12d, OFFSET FLAT:.LC9
	jmp	.L24
	.cfi_endproc
.LFE26:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
