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
	sub	rsp, 5400
	.cfi_def_cfa_offset 5456
	call	getenv
	mov	edx, OFFSET FLAT:.LC15
	mov	esi, 256
	lea	rdi, [rsp+528]
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
	lea	rdi, [rsp+784]
	call	snprintf
	mov	edx, OFFSET FLAT:.LC17
	xor	eax, eax
	mov	rcx, rbx
	mov	esi, 256
	lea	rdi, [rsp+1040]
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
	je	.L139
	mov	edi, OFFSET FLAT:x11_silent_error_handler
	call	XSetErrorHandler
	movsx	rax, DWORD PTR [rbx+224]
	mov	edi, 4
	sal	rax, 7
	add	rax, QWORD PTR [rbx+232]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rsp], rax
	call	xosd_create
	mov	QWORD PTR [rsp+24], rax
	test	rax, rax
	je	.L140
	mov	r15, rax
	xor	esi, esi
	mov	rdi, rax
	call	xosd_set_pos
	mov	rdi, r15
	mov	esi, 2
	call	xosd_set_align
	mov	rdi, r15
	mov	esi, 50
	call	xosd_set_horizontal_offset
	mov	rdi, r15
	mov	esi, 1
	call	xosd_set_shadow_offset
	mov	rdi, r15
	mov	esi, -1
	call	xosd_set_timeout
	mov	edi, 8
	call	xosd_create
	mov	r15, rax
	mov	QWORD PTR [rsp+8], rax
	test	rax, rax
	je	.L9
	mov	esi, 1
	mov	rdi, rax
	call	xosd_set_pos
	mov	esi, 2
	mov	rdi, r15
	call	xosd_set_align
	mov	esi, 1
	mov	rdi, r15
	call	xosd_set_shadow_offset
	or	esi, -1
	mov	rdi, r15
	call	xosd_set_timeout
.L9:
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC21
	xor	r15d, r15d
	xor	ebp, ebp
	mov	edi, OFFSET FLAT:.LC22
	lea	r12, [rsp+144]
	call	setenv
	call	tzset
	xor	edi, edi
	call	time
	pxor	xmm0, xmm0
	mov	QWORD PTR [rsp+32], rax
	mov	eax, -1
	mov	DWORD PTR [rsp+44], eax
	mov	DWORD PTR [rsp+40], eax
	lea	rax, [rsp+1300]
	mov	QWORD PTR [rsp+56], rax
	movaps	XMMWORD PTR [rsp+160], xmm0
	movaps	XMMWORD PTR [rsp+176], xmm0
	.p2align 4,,10
	.p2align 3
.L10:
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	je	.L141
.L11:
	mov	rdi, rbx
	lea	rsi, [rsp+1296]
	call	XNextEvent
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	jne	.L11
.L141:
	xor	esi, esi
	lea	rdi, [rsp+528]
	call	access
	test	eax, eax
	jne	.L12
	test	ebp, ebp
	jne	.L142
.L13:
	test	r15d, r15d
	je	.L14
	mov	rax, QWORD PTR [rsp+8]
	test	rax, rax
	je	.L14
	mov	rdi, rax
	xor	r15d, r15d
	call	xosd_hide
.L14:
	mov	edi, 200000
	xor	ebp, ebp
	call	usleep
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L12:
	sub	rsp, 8
	.cfi_def_cfa_offset 5464
	mov	rdi, rbx
	lea	rax, [rsp+96]
	push	rax
	.cfi_def_cfa_offset 5472
	lea	rax, [rsp+100]
	push	rax
	.cfi_def_cfa_offset 5480
	lea	rax, [rsp+104]
	push	rax
	.cfi_def_cfa_offset 5488
	mov	rsi, QWORD PTR [rsp+32]
	lea	r9, [rsp+108]
	lea	r8, [rsp+104]
	lea	rcx, [rsp+136]
	lea	rdx, [rsp+128]
	call	XQueryPointer
	add	rsp, 32
	.cfi_def_cfa_offset 5456
	test	eax, eax
	je	.L16
	mov	ebp, DWORD PTR [rsp+72]
	mov	r13d, DWORD PTR [rsp+76]
	cmp	ebp, DWORD PTR [rsp+40]
	jne	.L17
	cmp	DWORD PTR [rsp+44], r13d
	je	.L16
.L17:
	xor	edi, edi
	call	time
	mov	DWORD PTR [rsp+44], r13d
	mov	QWORD PTR [rsp+32], rax
	mov	DWORD PTR [rsp+40], ebp
.L16:
	xor	edi, edi
	call	time
	mov	QWORD PTR [rsp+112], rax
	sub	eax, DWORD PTR [rsp+32]
	cmp	eax, 99
	setg	BYTE PTR [rsp+16]
	jle	.L18
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	lea	rdi, [rsp+1040]
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
	lea	rsi, [rsp+1296]
	call	read
	mov	edi, ebp
	mov	r13, rax
	call	close
	test	r13, r13
	jle	.L22
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1296]
	mov	BYTE PTR [rsp+1296+r13], 0
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
	lea	rsi, [rsp+1296]
	call	read
	mov	edi, ebp
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L24
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1296]
	mov	BYTE PTR [rsp+1296+r14], 0
	call	strtol
	mov	r14d, OFFSET FLAT:.LC3
	cmp	eax, 1
	jne	.L24
.L26:
	lea	rsi, [rsp+192]
	lea	rdi, [rsp+112]
	call	localtime_r
	mov	eax, 715827883
	mov	r8d, r13d
	mov	rcx, r14
	mov	esi, DWORD PTR [rsp+200]
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
	.cfi_def_cfa_offset 5464
	mov	edx, OFFSET FLAT:.LC25
	mov	r9d, ebp
	push	rax
	.cfi_def_cfa_offset 5472
	mov	eax, DWORD PTR [rsp+208]
	push	rax
	.cfi_def_cfa_offset 5480
	mov	eax, DWORD PTR [rsp+220]
	push	rax
	.cfi_def_cfa_offset 5488
	xor	eax, eax
	lea	rdi, [rsp+288]
	call	snprintf
	add	rsp, 32
	.cfi_def_cfa_offset 5456
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
	lea	rcx, [rsp+384]
	mov	QWORD PTR [rsp+384], 0
	push	rcx
	.cfi_def_cfa_offset 5464
	lea	rcx, [rsp+160]
	push	rcx
	.cfi_def_cfa_offset 5472
	push	r12
	.cfi_def_cfa_offset 5480
	lea	rcx, [rsp+152]
	push	rcx
	.cfi_def_cfa_offset 5488
	lea	rcx, [rsp+168]
	push	rcx
	.cfi_def_cfa_offset 5496
	xor	ecx, ecx
	push	33
	.cfi_def_cfa_offset 5504
	mov	rsi, QWORD PTR [rsp+48]
	call	XGetWindowProperty
	add	rsp, 48
	.cfi_def_cfa_offset 5456
	test	eax, eax
	jne	.L36
	mov	r13, QWORD PTR [rsp+384]
	test	r13, r13
	je	.L36
	cmp	QWORD PTR [rsp+144], 0
	je	.L30
	mov	DWORD PTR [rsp+48], ebp
	xor	r14d, r14d
	.p2align 4,,10
	.p2align 3
.L35:
	mov	rsi, QWORD PTR [r13+0+r14*8]
	mov	rdi, rbx
	lea	rdx, [rsp+1296]
	mov	QWORD PTR [rsp+1296], 0
	call	XFetchName
	test	eax, eax
	jle	.L31
	mov	rbp, QWORD PTR [rsp+1296]
	test	rbp, rbp
	je	.L31
	mov	esi, OFFSET FLAT:.LC27
	mov	rdi, rbp
	call	strstr
	test	rax, rax
	jne	.L143
	mov	rdi, rbp
	call	XFree
.L31:
	add	r14, 1
	cmp	r14, QWORD PTR [rsp+144]
	jb	.L35
	mov	ebp, DWORD PTR [rsp+48]
	mov	r13, QWORD PTR [rsp+384]
.L30:
	mov	rdi, r13
	call	XFree
	.p2align 4,,10
	.p2align 3
.L36:
	xor	esi, esi
	lea	rdi, [rsp+784]
	xor	eax, eax
	call	open
	mov	r13d, eax
	test	eax, eax
	js	.L63
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1296]
	call	read
	mov	edi, r13d
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L63
	mov	esi, OFFSET FLAT:.LC28
	lea	rdi, [rsp+1296]
	mov	BYTE PTR [rsp+1296+r14], 0
	mov	r13d, OFFSET FLAT:.LC13
	call	strstr
	mov	r14d, OFFSET FLAT:.LC12
	mov	edx, OFFSET FLAT:.LC8
	test	rax, rax
	mov	eax, OFFSET FLAT:.LC9
	cmove	r14, rdx
	cmove	r13, rax
.L37:
	lea	rdi, [rsp+160]
	mov	rsi, r13
	call	strcmp
	test	eax, eax
	jne	.L144
.L38:
	mov	r13, QWORD PTR [rsp+24]
	lea	rcx, [rsp+256]
	mov	edx, 1
	xor	eax, eax
	mov	esi, 2
	mov	rdi, r13
	call	xosd_display
	mov	rcx, r14
	mov	edx, 1
	mov	rdi, r13
	mov	esi, 3
	xor	eax, eax
	call	xosd_display
	mov	rdi, r13
	call	xosd_show
	cmp	QWORD PTR [rsp+8], 0
	setne	al
	cmp	BYTE PTR [rsp+16], 0
	je	.L40
	test	al, al
	jne	.L145
.L40:
	test	r15d, r15d
	je	.L51
	test	al, al
	je	.L51
	mov	rdi, QWORD PTR [rsp+8]
	xor	r15d, r15d
	call	xosd_hide
.L51:
	mov	rsi, QWORD PTR [rsp]
	lea	r9, [rsp+92]
	mov	rdi, rbx
	lea	r8, [rsp+136]
	lea	rcx, [rsp+128]
	lea	rdx, [rsp+120]
	call	XQueryTree
	test	eax, eax
	je	.L53
	mov	esi, DWORD PTR [rsp+92]
	mov	rdi, QWORD PTR [rsp+136]
	test	esi, esi
	je	.L54
	xor	ebp, ebp
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L55:
	mov	rax, QWORD PTR [rsp+144]
	test	rax, rax
	je	.L138
	mov	edi, OFFSET FLAT:.LC30
	mov	ecx, 5
	mov	rsi, rax
	repz cmpsb
	mov	rdi, rax
	seta	dl
	sbb	dl, 0
	test	dl, dl
	jne	.L58
	call	XFree
	mov	rax, QWORD PTR [rsp+136]
	mov	rdi, rbx
	lea	rdx, [rsp+384]
	mov	rsi, QWORD PTR [rax+r13*8]
	call	XGetWindowAttributes
	mov	rdi, QWORD PTR [rsp+136]
	test	eax, eax
	je	.L56
	mov	ecx, DWORD PTR [rsp+476]
	test	ecx, ecx
	jne	.L146
.L56:
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+92]
	jnb	.L54
	.p2align 4,,10
	.p2align 3
.L61:
	mov	r13d, ebp
	mov	rdx, r12
	mov	QWORD PTR [rsp+144], 0
	mov	rsi, QWORD PTR [rdi+r13*8]
	mov	rdi, rbx
	call	XFetchName
	test	eax, eax
	jg	.L55
.L138:
	mov	rdi, QWORD PTR [rsp+136]
.L147:
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+92]
	jb	.L61
.L54:
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
.L58:
	call	XFree
	mov	rdi, QWORD PTR [rsp+136]
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L22:
	xor	r13d, r13d
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L24:
	mov	r14d, OFFSET FLAT:.LC4
	cmp	r13d, 84
	jg	.L26
	mov	r14d, OFFSET FLAT:.LC1
	cmp	r13d, 39
	jg	.L26
	cmp	r13d, 14
	mov	r14d, OFFSET FLAT:.LC2
	mov	eax, OFFSET FLAT:.LC5
	cmovle	r14, rax
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L18:
	lea	rdi, [rsp+1040]
	call	unlink
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L142:
	mov	rdi, QWORD PTR [rsp+24]
	call	xosd_hide
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L144:
	mov	rdi, QWORD PTR [rsp+24]
	mov	rsi, r13
	call	xosd_set_colour
	mov	rax, QWORD PTR [rsp+8]
	test	rax, rax
	je	.L39
	mov	rsi, r13
	mov	rdi, rax
	call	xosd_set_colour
.L39:
	mov	edx, 31
	mov	rsi, r13
	lea	rdi, [rsp+160]
	call	strncpy
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L63:
	mov	r14d, OFFSET FLAT:.LC8
	mov	r13d, OFFSET FLAT:.LC9
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L145:
	mov	ecx, ebp
	mov	edx, OFFSET FLAT:.LC29
	mov	esi, 16
	xor	eax, eax
	mov	r9d, DWORD PTR [rsp+192]
	mov	r8d, DWORD PTR [rsp+196]
	lea	rdi, [rsp+384]
	lea	r14, [rsp+385]
	call	snprintf
	mov	BYTE PTR [rsp+1296], 0
	movsx	r13, BYTE PTR [rsp+384]
	lea	rax, [rsp+3344]
	mov	BYTE PTR [rsp+1552], 0
	mov	BYTE PTR [rsp+1808], 0
	mov	BYTE PTR [rsp+2064], 0
	mov	BYTE PTR [rsp+2320], 0
	mov	BYTE PTR [rsp+2576], 0
	mov	BYTE PTR [rsp+2832], 0
	mov	BYTE PTR [rsp+3088], 0
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
	lea	rax, [rsp+1296]
	sal	rbp, 8
	add	rbp, rax
	mov	rdi, rbp
	cmp	r13b, 58
	je	.L148
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
.L149:
	mov	rbx, QWORD PTR [rsp+16]
.L50:
	mov	r13, QWORD PTR [rsp+8]
	xor	ebp, ebp
	.p2align 4,,10
	.p2align 3
.L42:
	mov	rcx, rbp
	lea	rax, [rsp+1296]
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
	mov	rdi, QWORD PTR [rsp+8]
	mov	r15d, 1
	call	xosd_show
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L148:
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
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L43:
	sal	r13, 6
	lea	rbp, [rsp+1296]
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
	cmp	r15, rbp
	jne	.L48
	add	r14, 1
	movsx	r13, BYTE PTR [r14-1]
	test	r13b, r13b
	jne	.L49
	jmp	.L149
.L146:
	mov	rax, QWORD PTR [rdi+r13*8]
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC31
	mov	rdi, rbx
	mov	QWORD PTR [rsp+16], rax
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
	lea	rdi, [rsp+1304]
	lea	r8, [rsp+1296]
	mov	rdx, rax
	mov	rax, QWORD PTR [rsp+56]
	mov	QWORD PTR [rax], 0
	sub	rax, rdi
	mov	QWORD PTR [rsp+1480], 0
	mov	rcx, rax
	xor	eax, eax
	add	ecx, 188
	shr	ecx, 3
	rep stosq
	mov	QWORD PTR [rsp+1368], rdx
	mov	rdi, rbx
	xor	edx, edx
	mov	ecx, 1572864
	mov	DWORD PTR [rsp+1296], 33
	movq	xmm0, QWORD PTR [rsp+16]
	mov	rsi, QWORD PTR [rsp]
	mov	DWORD PTR [rsp+1344], 32
	mov	QWORD PTR [rsp+1352], 1
	mov	QWORD PTR [rsp+1360], r14
	mov	QWORD PTR [rsp+1376], 1
	movhps	xmm0, QWORD PTR [rsp+48]
	movaps	XMMWORD PTR [rsp+1328], xmm0
	call	XSendEvent
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC34
	mov	rdi, rbx
	call	XInternAtom
	mov	ecx, 4294967295
	xor	r9d, r9d
	mov	rdi, rbx
	mov	QWORD PTR [rsp+152], rcx
	mov	rdx, rax
	mov	r8d, 32
	push	1
	.cfi_def_cfa_offset 5464
	lea	rcx, [rsp+160]
	push	rcx
	.cfi_def_cfa_offset 5472
	mov	rsi, QWORD PTR [rsp+32]
	mov	ecx, 6
	call	XChangeProperty
	mov	rax, QWORD PTR [rsp+152]
	mov	rdi, rbx
	mov	rsi, QWORD PTR [rax+r13*8]
	call	XRaiseWindow
	mov	rdi, QWORD PTR [rsp+152]
	pop	rax
	.cfi_def_cfa_offset 5464
	pop	rdx
	.cfi_def_cfa_offset 5456
	jmp	.L56
.L143:
	mov	rdx, rbp
	mov	ebp, DWORD PTR [rsp+48]
	mov	rdi, rdx
	call	XFree
	mov	rdi, QWORD PTR [rsp+384]
	call	XFree
	xor	esi, esi
	lea	rdi, [rsp+784]
	xor	eax, eax
	call	open
	mov	r13d, eax
	test	eax, eax
	jns	.L150
.L33:
	mov	r14d, OFFSET FLAT:.LC10
	mov	r13d, OFFSET FLAT:.LC11
	jmp	.L37
.L139:
	mov	edx, 33
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC19
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
.L131:
	add	rsp, 5400
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
.L140:
	.cfi_restore_state
	mov	edx, 34
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC20
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	mov	rdi, rbx
	call	XCloseDisplay
	jmp	.L131
.L150:
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1296]
	call	read
	mov	edi, r13d
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L33
	mov	BYTE PTR [rsp+1296+r14], 0
	mov	r13d, OFFSET FLAT:.LC11
	mov	r14d, OFFSET FLAT:.LC10
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
