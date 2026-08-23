	.file	"clock_osd.c"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.type	x11_silent_error_handler, @function
x11_silent_error_handler:
.LFB33:
	.cfi_startproc
	xor	eax, eax
	ret
	.cfi_endproc
.LFE33:
	.size	x11_silent_error_handler, .-x11_silent_error_handler
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"/home/user"
.LC1:
	.string	"[==-]"
.LC2:
	.string	"[=--]"
.LC3:
	.string	"AC"
.LC4:
	.string	"[===]"
.LC5:
	.string	"[---]"
.LC6:
	.string	"p.m."
.LC7:
	.string	"a.m."
.LC8:
	.string	"Mouse quit Alt+1"
.LC9:
	.string	"orange"
.LC10:
	.string	"Xephyr quit Ctrl+Shift"
.LC11:
	.string	"red"
.LC12:
	.string	"Keyboard quit Alt+2"
.LC13:
	.string	"green"
.LC14:
	.string	"HOME"
.LC15:
	.string	"%s/.stop_personal_osdx"
.LC16:
	.string	"%s/.xbindkeysrc"
.LC17:
	.string	"%s/.big_hour"
.LC18:
	.string	"/tmp/clock_is_run_already.pid"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC19:
	.string	"clock_osd: Cannot open X Display\n"
	.align 8
.LC20:
	.string	"clock_osd: Cannot create top XOSD\n"
	.section	.rodata.str1.1
.LC21:
	.string	"America/Lima"
.LC22:
	.string	"TZ"
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"/sys/class/power_supply/BAT0/capacity"
	.align 8
.LC24:
	.string	"/sys/class/power_supply/ADP1/online"
	.section	.rodata.str1.1
.LC25:
	.string	"%s %d%% %02d:%02d:%02d %s"
.LC26:
	.string	"_NET_CLIENT_LIST"
.LC27:
	.string	"ctrl+shift releases"
.LC28:
	.string	"NOT MOUSE"
.LC29:
	.string	"%02d:%02d:%02d"
.LC30:
	.string	"XOSD"
.LC31:
	.string	"_NET_WM_STATE"
.LC32:
	.string	"_NET_WM_STATE_STICKY"
.LC33:
	.string	"_NET_WM_STATE_ABOVE"
.LC34:
	.string	"_NET_WM_DESKTOP"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	mov	edi, OFFSET FLAT:.LC14
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
	sub	rsp, 5272
	.cfi_def_cfa_offset 5328
	call	getenv
	mov	edx, OFFSET FLAT:.LC15
	mov	esi, 256
	lea	rdi, [rsp+400]
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
	lea	rdi, [rsp+656]
	call	snprintf
	mov	edx, OFFSET FLAT:.LC17
	xor	eax, eax
	mov	rcx, rbx
	mov	esi, 256
	lea	rdi, [rsp+912]
	call	snprintf
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	mov	edi, OFFSET FLAT:.LC18
	call	open
	test	eax, eax
	js	.L5
	mov	edi, eax
	call	close
.L5:
	xor	edi, edi
	call	XOpenDisplay
	mov	rbx, rax
	test	rax, rax
	je	.L135
	mov	edi, OFFSET FLAT:x11_silent_error_handler
	call	XSetErrorHandler
	movsx	rax, DWORD PTR [rbx+224]
	mov	edi, 4
	sal	rax, 7
	add	rax, QWORD PTR [rbx+232]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rsp+8], rax
	call	xosd_create
	mov	QWORD PTR [rsp+40], rax
	test	rax, rax
	je	.L136
	mov	r14, rax
	xor	esi, esi
	mov	rdi, rax
	call	xosd_set_pos
	mov	rdi, r14
	mov	esi, 2
	call	xosd_set_align
	mov	rdi, r14
	mov	esi, 50
	call	xosd_set_horizontal_offset
	mov	rdi, r14
	mov	esi, 1
	call	xosd_set_shadow_offset
	mov	rdi, r14
	mov	esi, -1
	call	xosd_set_timeout
	mov	edi, 8
	call	xosd_create
	mov	r14, rax
	mov	QWORD PTR [rsp+24], rax
	test	rax, rax
	je	.L9
	mov	esi, 1
	mov	rdi, rax
	call	xosd_set_pos
	mov	esi, 2
	mov	rdi, r14
	call	xosd_set_align
	mov	esi, 1
	mov	rdi, r14
	call	xosd_set_shadow_offset
	or	esi, -1
	mov	rdi, r14
	call	xosd_set_timeout
.L9:
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC21
	mov	edi, OFFSET FLAT:.LC22
	xor	ebp, ebp
	call	setenv
	lea	r12, [rsp+152]
	call	tzset
	xor	edi, edi
	call	time
	mov	DWORD PTR [rsp+16], 0
	pxor	xmm0, xmm0
	mov	QWORD PTR [rsp+56], rax
	mov	eax, -1
	mov	DWORD PTR [rsp+68], eax
	mov	DWORD PTR [rsp+64], eax
	lea	rax, [rsp+1172]
	mov	QWORD PTR [rsp+72], rax
	movaps	XMMWORD PTR [rsp+176], xmm0
	movaps	XMMWORD PTR [rsp+192], xmm0
	.p2align 4,,10
	.p2align 3
.L10:
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	je	.L137
.L11:
	mov	rdi, rbx
	lea	rsi, [rsp+1168]
	call	XNextEvent
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	jne	.L11
.L137:
	xor	esi, esi
	lea	rdi, [rsp+400]
	call	access
	test	eax, eax
	jne	.L12
	test	ebp, ebp
	jne	.L138
.L13:
	mov	r10d, DWORD PTR [rsp+16]
	test	r10d, r10d
	je	.L14
	mov	rax, QWORD PTR [rsp+24]
	test	rax, rax
	je	.L14
	mov	rdi, rax
	call	xosd_hide
	mov	DWORD PTR [rsp+16], 0
.L14:
	mov	edi, 200000
	xor	ebp, ebp
	call	usleep
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L12:
	sub	rsp, 8
	.cfi_def_cfa_offset 5336
	mov	rdi, rbx
	lea	rax, [rsp+104]
	push	rax
	.cfi_def_cfa_offset 5344
	lea	rax, [rsp+108]
	push	rax
	.cfi_def_cfa_offset 5352
	lea	rax, [rsp+112]
	push	rax
	.cfi_def_cfa_offset 5360
	mov	rsi, QWORD PTR [rsp+40]
	lea	r9, [rsp+116]
	lea	r8, [rsp+112]
	lea	rcx, [rsp+144]
	lea	rdx, [rsp+136]
	call	XQueryPointer
	add	rsp, 32
	.cfi_def_cfa_offset 5328
	test	eax, eax
	je	.L16
	mov	ebp, DWORD PTR [rsp+80]
	mov	r13d, DWORD PTR [rsp+84]
	cmp	ebp, DWORD PTR [rsp+64]
	jne	.L17
	cmp	DWORD PTR [rsp+68], r13d
	je	.L16
.L17:
	xor	edi, edi
	call	time
	mov	DWORD PTR [rsp+68], r13d
	mov	QWORD PTR [rsp+56], rax
	mov	DWORD PTR [rsp+64], ebp
.L16:
	xor	edi, edi
	call	time
	mov	QWORD PTR [rsp+120], rax
	sub	eax, DWORD PTR [rsp+56]
	cmp	eax, 99
	setg	r14b
	jle	.L18
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	lea	rdi, [rsp+912]
	call	open
	test	eax, eax
	js	.L19
	mov	edi, eax
	call	close
.L19:
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC23
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L22
	mov	edi, eax
	mov	edx, 31
	lea	rsi, [rsp+1168]
	call	read
	mov	edi, ebp
	mov	r13, rax
	call	close
	test	r13, r13
	jle	.L22
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1168]
	mov	BYTE PTR [rsp+1168+r13], 0
	call	strtol
	mov	r13d, eax
.L21:
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC24
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L24
	mov	edi, eax
	mov	edx, 31
	lea	rsi, [rsp+1168]
	call	read
	mov	edi, ebp
	mov	r15, rax
	call	close
	test	r15, r15
	jle	.L24
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1168]
	mov	BYTE PTR [rsp+1168+r15], 0
	call	strtol
	mov	r15d, OFFSET FLAT:.LC3
	cmp	eax, 1
	jne	.L24
.L26:
	lea	rsi, [rsp+208]
	lea	rdi, [rsp+120]
	call	localtime_r
	mov	eax, 715827883
	mov	r8d, r13d
	mov	rcx, r15
	mov	esi, DWORD PTR [rsp+216]
	imul	esi
	mov	eax, esi
	mov	ebp, esi
	sar	eax, 31
	sar	edx
	sub	edx, eax
	lea	eax, [rdx+rdx*2]
	mov	edx, OFFSET FLAT:.LC7
	sal	eax, 2
	sub	ebp, eax
	mov	eax, 12
	cmove	ebp, eax
	cmp	esi, 11
	mov	eax, OFFSET FLAT:.LC6
	mov	esi, 128
	cmovle	rax, rdx
	sub	rsp, 8
	.cfi_def_cfa_offset 5336
	mov	edx, OFFSET FLAT:.LC25
	mov	r9d, ebp
	push	rax
	.cfi_def_cfa_offset 5344
	mov	eax, DWORD PTR [rsp+224]
	push	rax
	.cfi_def_cfa_offset 5352
	mov	eax, DWORD PTR [rsp+236]
	push	rax
	.cfi_def_cfa_offset 5360
	xor	eax, eax
	lea	rdi, [rsp+304]
	call	snprintf
	add	rsp, 32
	.cfi_def_cfa_offset 5328
	mov	edx, 1
	mov	rdi, rbx
	mov	esi, OFFSET FLAT:.LC26
	call	XInternAtom
	test	rax, rax
	je	.L36
	xor	r9d, r9d
	mov	r8d, 1024
	mov	rdx, rax
	mov	rdi, rbx
	lea	rcx, [rsp+160]
	mov	QWORD PTR [rsp+160], 0
	push	rcx
	.cfi_def_cfa_offset 5336
	push	r12
	.cfi_def_cfa_offset 5344
	lea	rcx, [rsp+160]
	push	rcx
	.cfi_def_cfa_offset 5352
	lea	rcx, [rsp+152]
	push	rcx
	.cfi_def_cfa_offset 5360
	lea	rcx, [rsp+168]
	push	rcx
	.cfi_def_cfa_offset 5368
	xor	ecx, ecx
	push	33
	.cfi_def_cfa_offset 5376
	mov	rsi, QWORD PTR [rsp+56]
	call	XGetWindowProperty
	add	rsp, 48
	.cfi_def_cfa_offset 5328
	test	eax, eax
	jne	.L36
	mov	r15, QWORD PTR [rsp+160]
	test	r15, r15
	je	.L36
	cmp	QWORD PTR [rsp+144], 0
	je	.L30
	mov	DWORD PTR [rsp+32], ebp
	xor	r13d, r13d
	.p2align 4,,10
	.p2align 3
.L35:
	mov	rsi, QWORD PTR [r15+r13*8]
	mov	rdi, rbx
	lea	rdx, [rsp+1168]
	mov	QWORD PTR [rsp+1168], 0
	call	XFetchName
	test	eax, eax
	jle	.L31
	mov	rbp, QWORD PTR [rsp+1168]
	test	rbp, rbp
	je	.L31
	mov	esi, OFFSET FLAT:.LC27
	mov	rdi, rbp
	call	strstr
	test	rax, rax
	jne	.L139
	mov	rdi, rbp
	call	XFree
.L31:
	add	r13, 1
	cmp	r13, QWORD PTR [rsp+144]
	jb	.L35
	mov	ebp, DWORD PTR [rsp+32]
	mov	r15, QWORD PTR [rsp+160]
.L30:
	mov	rdi, r15
	call	XFree
	.p2align 4,,10
	.p2align 3
.L36:
	xor	esi, esi
	lea	rdi, [rsp+656]
	xor	eax, eax
	call	open
	mov	r13d, eax
	test	eax, eax
	js	.L60
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1168]
	call	read
	mov	edi, r13d
	mov	r15, rax
	call	close
	test	r15, r15
	jle	.L60
	mov	esi, OFFSET FLAT:.LC28
	lea	rdi, [rsp+1168]
	mov	BYTE PTR [rsp+1168+r15], 0
	mov	r13d, OFFSET FLAT:.LC13
	call	strstr
	mov	r15d, OFFSET FLAT:.LC12
	mov	edx, OFFSET FLAT:.LC8
	test	rax, rax
	mov	eax, OFFSET FLAT:.LC9
	cmove	r15, rdx
	cmove	r13, rax
.L37:
	lea	rdi, [rsp+176]
	mov	rsi, r13
	call	strcmp
	test	eax, eax
	jne	.L140
.L38:
	mov	r13, QWORD PTR [rsp+40]
	lea	rcx, [rsp+272]
	mov	edx, 1
	xor	eax, eax
	mov	esi, 2
	mov	rdi, r13
	call	xosd_display
	mov	rcx, r15
	mov	edx, 1
	mov	rdi, r13
	mov	esi, 3
	xor	eax, eax
	call	xosd_display
	mov	rdi, r13
	call	xosd_show
	cmp	QWORD PTR [rsp+24], 0
	setne	al
	test	r14b, r14b
	je	.L40
	test	al, al
	jne	.L141
.L40:
	mov	esi, DWORD PTR [rsp+16]
	test	esi, esi
	je	.L51
	test	al, al
	je	.L51
	mov	rdi, QWORD PTR [rsp+24]
	call	xosd_hide
	mov	DWORD PTR [rsp+16], 0
.L51:
	mov	rsi, QWORD PTR [rsp+8]
	lea	r9, [rsp+100]
	lea	r8, [rsp+144]
	mov	rdi, rbx
	lea	rcx, [rsp+136]
	lea	rdx, [rsp+128]
	call	XQueryTree
	test	eax, eax
	je	.L53
	mov	ecx, DWORD PTR [rsp+100]
	xor	ebp, ebp
	mov	r15, QWORD PTR [rsp+72]
	test	ecx, ecx
	jne	.L54
	jmp	.L59
	.p2align 4,,10
	.p2align 3
.L142:
	call	XFree
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC31
	mov	rdi, rbx
	mov	rax, QWORD PTR [rsp+144]
	mov	rax, QWORD PTR [rax+r13*8]
	mov	QWORD PTR [rsp+32], rax
	call	XInternAtom
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC32
	mov	rdi, rbx
	mov	QWORD PTR [rsp+48], rax
	call	XInternAtom
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC33
	mov	rdi, rbx
	mov	r14, rax
	call	XInternAtom
	lea	rdi, [rsp+1176]
	mov	rcx, r15
	mov	QWORD PTR [r15], 0
	sub	rcx, rdi
	mov	rdx, rax
	xor	eax, eax
	mov	QWORD PTR [rsp+1352], 0
	add	ecx, 188
	lea	r8, [rsp+1168]
	shr	ecx, 3
	rep stosq
	mov	QWORD PTR [rsp+1240], rdx
	mov	rdi, rbx
	xor	edx, edx
	mov	ecx, 1572864
	mov	DWORD PTR [rsp+1168], 33
	movq	xmm0, QWORD PTR [rsp+32]
	mov	rsi, QWORD PTR [rsp+8]
	mov	DWORD PTR [rsp+1216], 32
	mov	QWORD PTR [rsp+1224], 1
	mov	QWORD PTR [rsp+1232], r14
	mov	QWORD PTR [rsp+1248], 1
	movhps	xmm0, QWORD PTR [rsp+48]
	movaps	XMMWORD PTR [rsp+1200], xmm0
	call	XSendEvent
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC34
	mov	rdi, rbx
	call	XInternAtom
	mov	ecx, 4294967295
	xor	r9d, r9d
	mov	rdi, rbx
	mov	QWORD PTR [rsp+160], rcx
	mov	rdx, rax
	mov	r8d, 32
	push	1
	.cfi_def_cfa_offset 5336
	lea	rcx, [rsp+168]
	push	rcx
	.cfi_def_cfa_offset 5344
	mov	rsi, QWORD PTR [rsp+48]
	mov	ecx, 6
	call	XChangeProperty
	mov	rax, QWORD PTR [rsp+160]
	mov	rdi, rbx
	mov	rsi, QWORD PTR [rax+r13*8]
	call	XMapWindow
	mov	rax, QWORD PTR [rsp+160]
	mov	rdi, rbx
	mov	rsi, QWORD PTR [rax+r13*8]
	call	XRaiseWindow
	pop	rax
	.cfi_def_cfa_offset 5336
	pop	rdx
	.cfi_def_cfa_offset 5328
.L57:
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+100]
	jnb	.L59
.L54:
	mov	rax, QWORD PTR [rsp+144]
	mov	r13d, ebp
	mov	rdx, r12
	mov	rdi, rbx
	mov	QWORD PTR [rsp+152], 0
	mov	rsi, QWORD PTR [rax+r13*8]
	call	XFetchName
	test	eax, eax
	jle	.L57
	mov	rax, QWORD PTR [rsp+152]
	test	rax, rax
	je	.L57
	mov	edi, OFFSET FLAT:.LC30
	mov	ecx, 5
	mov	rsi, rax
	repz cmpsb
	mov	rdi, rax
	seta	dl
	sbb	dl, 0
	test	dl, dl
	je	.L142
	call	XFree
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+100]
	jb	.L54
	.p2align 4,,10
	.p2align 3
.L59:
	mov	rdi, QWORD PTR [rsp+144]
	test	rdi, rdi
	je	.L53
	call	XFree
.L53:
	mov	edi, 100000
	mov	ebp, 1
	call	usleep
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L22:
	xor	r13d, r13d
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L24:
	mov	r15d, OFFSET FLAT:.LC4
	cmp	r13d, 84
	jg	.L26
	mov	r15d, OFFSET FLAT:.LC1
	cmp	r13d, 39
	jg	.L26
	cmp	r13d, 14
	mov	r15d, OFFSET FLAT:.LC2
	mov	eax, OFFSET FLAT:.LC5
	cmovle	r15, rax
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L18:
	lea	rdi, [rsp+912]
	call	unlink
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L138:
	mov	rdi, QWORD PTR [rsp+40]
	call	xosd_hide
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L140:
	mov	rdi, QWORD PTR [rsp+40]
	mov	rsi, r13
	call	xosd_set_colour
	mov	rax, QWORD PTR [rsp+24]
	test	rax, rax
	je	.L39
	mov	rsi, r13
	mov	rdi, rax
	call	xosd_set_colour
.L39:
	mov	edx, 31
	mov	rsi, r13
	lea	rdi, [rsp+176]
	call	strncpy
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L60:
	mov	r15d, OFFSET FLAT:.LC8
	mov	r13d, OFFSET FLAT:.LC9
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L141:
	mov	ecx, ebp
	mov	edx, OFFSET FLAT:.LC29
	mov	esi, 16
	xor	eax, eax
	mov	r9d, DWORD PTR [rsp+208]
	mov	r8d, DWORD PTR [rsp+212]
	lea	rdi, [rsp+160]
	lea	r14, [rsp+161]
	call	snprintf
	mov	BYTE PTR [rsp+1168], 0
	movsx	r13, BYTE PTR [rsp+160]
	lea	rax, [rsp+3216]
	mov	BYTE PTR [rsp+1424], 0
	mov	BYTE PTR [rsp+1680], 0
	mov	BYTE PTR [rsp+1936], 0
	mov	BYTE PTR [rsp+2192], 0
	mov	BYTE PTR [rsp+2448], 0
	mov	BYTE PTR [rsp+2704], 0
	mov	BYTE PTR [rsp+2960], 0
	test	r13b, r13b
	je	.L50
	mov	QWORD PTR [rsp+16], rbx
	mov	r15, rax
	.p2align 4,,10
	.p2align 3
.L49:
	lea	eax, [r13-48]
	cmp	al, 9
	jbe	.L43
	xor	ebx, ebx
	.p2align 4,,10
	.p2align 3
.L47:
	mov	rbp, rbx
	lea	rax, [rsp+1168]
	sal	rbp, 8
	add	rbp, rax
	mov	rdi, rbp
	cmp	r13b, 58
	je	.L143
	call	strlen
	add	rbx, 1
	mov	r8d, 32
	mov	WORD PTR [rbp+0+rax], r8w
	cmp	rbx, 8
	jne	.L47
	add	r14, 1
	movsx	r13, BYTE PTR [r14-1]
	test	r13b, r13b
	jne	.L49
.L144:
	mov	rbx, QWORD PTR [rsp+16]
.L50:
	mov	r13, QWORD PTR [rsp+24]
	xor	ebp, ebp
	.p2align 4,,10
	.p2align 3
.L42:
	mov	rcx, rbp
	lea	rax, [rsp+1168]
	mov	esi, ebp
	mov	rdi, r13
	sal	rcx, 8
	mov	edx, 1
	add	rbp, 1
	add	rcx, rax
	xor	eax, eax
	call	xosd_display
	cmp	rbp, 8
	jne	.L42
	mov	rdi, QWORD PTR [rsp+24]
	call	xosd_show
	mov	DWORD PTR [rsp+16], 1
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L143:
	call	strlen
	mov	rsi, QWORD PTR ascii_colon[0+rbx*8]
	add	rbx, 1
	lea	rdi, [rbp+0+rax]
	call	stpcpy
	mov	r9d, 32
	mov	WORD PTR [rax], r9w
	cmp	rbx, 8
	jne	.L47
	add	r14, 1
	movsx	r13, BYTE PTR [r14-1]
	test	r13b, r13b
	jne	.L49
	jmp	.L144
	.p2align 4,,10
	.p2align 3
.L43:
	sal	r13, 6
	lea	rbp, [rsp+1168]
	add	r13, OFFSET FLAT:ascii_v-3072
	.p2align 4,,10
	.p2align 3
.L48:
	mov	rdi, rbp
	add	r13, 8
	call	strlen
	mov	rsi, QWORD PTR [r13-8]
	lea	rdi, [rbp+0+rax]
	add	rbp, 256
	call	stpcpy
	mov	edi, 32
	mov	WORD PTR [rax], di
	cmp	rbp, r15
	jne	.L48
	add	r14, 1
	movsx	r13, BYTE PTR [r14-1]
	test	r13b, r13b
	jne	.L49
	jmp	.L144
.L139:
	mov	rdx, rbp
	mov	ebp, DWORD PTR [rsp+32]
	mov	rdi, rdx
	call	XFree
	mov	rdi, QWORD PTR [rsp+160]
	call	XFree
	xor	esi, esi
	lea	rdi, [rsp+656]
	xor	eax, eax
	call	open
	mov	r13d, eax
	test	eax, eax
	jns	.L145
.L33:
	mov	r15d, OFFSET FLAT:.LC10
	mov	r13d, OFFSET FLAT:.LC11
	jmp	.L37
.L135:
	mov	edx, 33
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC19
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
.L127:
	add	rsp, 5272
	.cfi_remember_state
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
.L136:
	.cfi_restore_state
	mov	edx, 34
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC20
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	mov	rdi, rbx
	call	XCloseDisplay
	jmp	.L127
.L145:
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1168]
	call	read
	mov	edi, r13d
	mov	r15, rax
	call	close
	test	r15, r15
	jle	.L33
	mov	BYTE PTR [rsp+1168+r15], 0
	mov	r13d, OFFSET FLAT:.LC11
	mov	r15d, OFFSET FLAT:.LC10
	jmp	.L37
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.str1.1
.LC35:
	.string	"    "
.LC36:
	.string	" /$$"
.LC37:
	.string	"|__/"
	.section	.rodata
	.align 32
	.type	ascii_colon, @object
	.size	ascii_colon, 64
ascii_colon:
	.quad	.LC35
	.quad	.LC36
	.quad	.LC37
	.quad	.LC35
	.quad	.LC36
	.quad	.LC37
	.quad	.LC35
	.quad	.LC35
	.section	.rodata.str1.1
.LC38:
	.string	"  /$$$$$$ "
.LC39:
	.string	" /$$$_  $$"
.LC40:
	.string	"| $$$$\\ $$"
.LC41:
	.string	"| $$ $$ $$"
.LC42:
	.string	"| $$\\ $$$$"
.LC43:
	.string	"| $$ \\ $$$"
.LC44:
	.string	"|  $$$$$$/"
.LC45:
	.string	" \\______/ "
.LC46:
	.string	"   /$$  "
.LC47:
	.string	" /$$$$  "
.LC48:
	.string	"|_  $$  "
.LC49:
	.string	"  | $$  "
.LC50:
	.string	" /$$$$$$"
.LC51:
	.string	"|______/"
.LC52:
	.string	" /$$__  $$"
.LC53:
	.string	"|__/  \\ $$"
.LC54:
	.string	"  /$$$$$$/"
.LC55:
	.string	" /$$____/ "
.LC56:
	.string	"| $$      "
.LC57:
	.string	"| $$$$$$$$"
.LC58:
	.string	"|________/"
.LC59:
	.string	"   /$$$$$/"
.LC60:
	.string	"  |___  $$"
.LC61:
	.string	" /$$  \\ $$"
.LC62:
	.string	" /$$   /$$"
.LC63:
	.string	"| $$  | $$"
.LC64:
	.string	"|_____  $$"
.LC65:
	.string	"      | $$"
.LC66:
	.string	"      |__/"
.LC67:
	.string	" /$$$$$$$ "
.LC68:
	.string	"| $$____/ "
.LC69:
	.string	"| $$$$$$$ "
.LC70:
	.string	"| $$  \\__/"
.LC71:
	.string	"| $$__  $$"
.LC72:
	.string	"| $$  \\ $$"
.LC73:
	.string	" /$$$$$$$$"
.LC74:
	.string	"|_____ $$/"
.LC75:
	.string	"     /$$/ "
.LC76:
	.string	"    /$$/  "
.LC77:
	.string	"   /$$/   "
.LC78:
	.string	"  /$$/    "
.LC79:
	.string	" /$$/     "
.LC80:
	.string	"|__/      "
.LC81:
	.string	" >$$__  $$"
.LC82:
	.string	"|  $$$$$$$"
.LC83:
	.string	" \\____  $$"
	.section	.rodata
	.align 32
	.type	ascii_v, @object
	.size	ascii_v, 640
ascii_v:
	.quad	.LC38
	.quad	.LC39
	.quad	.LC40
	.quad	.LC41
	.quad	.LC42
	.quad	.LC43
	.quad	.LC44
	.quad	.LC45
	.quad	.LC46
	.quad	.LC47
	.quad	.LC48
	.quad	.LC49
	.quad	.LC49
	.quad	.LC49
	.quad	.LC50
	.quad	.LC51
	.quad	.LC38
	.quad	.LC52
	.quad	.LC53
	.quad	.LC54
	.quad	.LC55
	.quad	.LC56
	.quad	.LC57
	.quad	.LC58
	.quad	.LC38
	.quad	.LC52
	.quad	.LC53
	.quad	.LC59
	.quad	.LC60
	.quad	.LC61
	.quad	.LC44
	.quad	.LC45
	.quad	.LC62
	.quad	.LC63
	.quad	.LC63
	.quad	.LC57
	.quad	.LC64
	.quad	.LC65
	.quad	.LC65
	.quad	.LC66
	.quad	.LC67
	.quad	.LC68
	.quad	.LC56
	.quad	.LC69
	.quad	.LC64
	.quad	.LC61
	.quad	.LC44
	.quad	.LC45
	.quad	.LC38
	.quad	.LC52
	.quad	.LC70
	.quad	.LC69
	.quad	.LC71
	.quad	.LC72
	.quad	.LC44
	.quad	.LC45
	.quad	.LC73
	.quad	.LC74
	.quad	.LC75
	.quad	.LC76
	.quad	.LC77
	.quad	.LC78
	.quad	.LC79
	.quad	.LC80
	.quad	.LC38
	.quad	.LC52
	.quad	.LC72
	.quad	.LC44
	.quad	.LC81
	.quad	.LC72
	.quad	.LC44
	.quad	.LC45
	.quad	.LC38
	.quad	.LC52
	.quad	.LC72
	.quad	.LC82
	.quad	.LC83
	.quad	.LC61
	.quad	.LC44
	.quad	.LC45
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
