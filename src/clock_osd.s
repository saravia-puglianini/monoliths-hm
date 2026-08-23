	.file	"clock_osd.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.type	x11_silent_error_handler, @function
x11_silent_error_handler:
.LFB80:
	.cfi_startproc
	endbr64
	xor	eax, eax
	ret
	.cfi_endproc
.LFE80:
	.size	x11_silent_error_handler, .-x11_silent_error_handler
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"/home/user"
.LC1:
	.string	"AC"
.LC2:
	.string	"[===]"
.LC3:
	.string	"[==-]"
.LC4:
	.string	"[=--]"
.LC5:
	.string	"[---]"
.LC6:
	.string	"p.m."
.LC7:
	.string	"a.m."
.LC8:
	.string	"Xephyr quit Ctrl+Shift"
.LC9:
	.string	"red"
.LC10:
	.string	"Keyboard quit Alt+2"
.LC11:
	.string	"green"
.LC12:
	.string	"Mouse quit Alt+1"
.LC13:
	.string	"orange"
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
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB86:
	.cfi_startproc
	endbr64
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
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 4096
	.cfi_def_cfa_offset 4152
	or	QWORD PTR [rsp], 0
	sub	rsp, 3416
	.cfi_def_cfa_offset 7568
	lea	rbx, .LC0[rip]
	mov	rdi, QWORD PTR fs:40
	mov	QWORD PTR 7496[rsp], rdi
	lea	rdi, .LC14[rip]
	call	getenv@PLT
	mov	ecx, 256
	mov	edx, 1
	lea	r8, .LC15[rip]
	test	rax, rax
	mov	esi, 256
	cmovne	rbx, rax
	lea	rax, 2624[rsp]
	mov	rdi, rax
	mov	QWORD PTR 32[rsp], rax
	xor	eax, eax
	mov	r9, rbx
	call	__snprintf_chk@PLT
	lea	rax, 2880[rsp]
	mov	r9, rbx
	lea	r8, .LC16[rip]
	mov	rdi, rax
	mov	ecx, 256
	mov	edx, 1
	mov	QWORD PTR 128[rsp], rax
	mov	esi, 256
	xor	eax, eax
	call	__snprintf_chk@PLT
	lea	rax, 3136[rsp]
	mov	edx, 1
	mov	r9, rbx
	mov	rdi, rax
	mov	QWORD PTR 120[rsp], rax
	xor	eax, eax
	mov	esi, 256
	lea	r8, .LC17[rip]
	mov	ecx, 256
	call	__snprintf_chk@PLT
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	lea	rdi, .LC18[rip]
	call	open@PLT
	test	eax, eax
	js	.L5
	mov	edi, eax
	call	close@PLT
.L5:
	xor	edi, edi
	call	XOpenDisplay@PLT
	mov	rbx, rax
	test	rax, rax
	je	.L146
	lea	rdi, x11_silent_error_handler[rip]
	call	XSetErrorHandler@PLT
	movsxd	rax, DWORD PTR 224[rbx]
	mov	edi, 4
	sal	rax, 7
	add	rax, QWORD PTR 232[rbx]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR 8[rsp], rax
	call	xosd_create@PLT
	mov	QWORD PTR 64[rsp], rax
	test	rax, rax
	je	.L147
	mov	r15, rax
	xor	esi, esi
	mov	rdi, rax
	call	xosd_set_pos@PLT
	mov	rdi, r15
	mov	esi, 2
	call	xosd_set_align@PLT
	mov	rdi, r15
	mov	esi, 50
	call	xosd_set_horizontal_offset@PLT
	mov	rdi, r15
	mov	esi, 1
	call	xosd_set_shadow_offset@PLT
	mov	rdi, r15
	mov	esi, -1
	call	xosd_set_timeout@PLT
	mov	edi, 8
	call	xosd_create@PLT
	mov	QWORD PTR 112[rsp], rax
	mov	r15, rax
	test	rax, rax
	je	.L9
	mov	esi, 1
	mov	rdi, rax
	call	xosd_set_pos@PLT
	mov	esi, 2
	mov	rdi, r15
	call	xosd_set_align@PLT
	mov	esi, 1
	mov	rdi, r15
	call	xosd_set_shadow_offset@PLT
	mov	esi, -1
	mov	rdi, r15
	call	xosd_set_timeout@PLT
.L9:
	mov	edx, 1
	lea	rsi, .LC21[rip]
	lea	rdi, .LC22[rip]
	call	setenv@PLT
	lea	r12, 2464[rsp]
	call	tzset@PLT
	xor	edi, edi
	call	time@PLT
	pxor	xmm0, xmm0
	mov	DWORD PTR 20[rsp], 0
	cmp	QWORD PTR 112[rsp], 0
	mov	QWORD PTR 104[rsp], rax
	lea	rax, 416[rsp]
	mov	QWORD PTR [rsp], rax
	lea	rax, 268[rsp]
	mov	QWORD PTR 144[rsp], rax
	lea	rax, 264[rsp]
	mov	QWORD PTR 136[rsp], rax
	lea	rax, 296[rsp]
	mov	QWORD PTR 184[rsp], rax
	lea	rax, 288[rsp]
	mov	QWORD PTR 176[rsp], rax
	lea	rax, 280[rsp]
	mov	QWORD PTR 168[rsp], rax
	lea	rax, 276[rsp]
	mov	QWORD PTR 160[rsp], rax
	lea	rax, 272[rsp]
	mov	QWORD PTR 152[rsp], rax
	lea	rax, 3392[rsp]
	mov	QWORD PTR 24[rsp], rax
	lea	rax, 352[rsp]
	mov	QWORD PTR 200[rsp], rax
	lea	rax, 304[rsp]
	mov	QWORD PTR 192[rsp], rax
	lea	rax, 2496[rsp]
	mov	QWORD PTR 40[rsp], rax
	lea	rax, 336[rsp]
	mov	QWORD PTR 216[rsp], rax
	lea	rax, 328[rsp]
	mov	QWORD PTR 96[rsp], rax
	lea	rax, 320[rsp]
	mov	QWORD PTR 88[rsp], rax
	lea	rax, 284[rsp]
	mov	QWORD PTR 72[rsp], rax
	lea	rax, 312[rsp]
	mov	QWORD PTR 80[rsp], rax
	lea	rax, 344[rsp]
	mov	QWORD PTR 208[rsp], rax
	lea	rax, 420[rsp]
	mov	QWORD PTR 232[rsp], rax
	lea	rax, 428[rsp]
	mov	DWORD PTR 248[rsp], -1
	mov	DWORD PTR 228[rsp], -1
	mov	QWORD PTR 240[rsp], rax
	setne	BYTE PTR 227[rsp]
	xor	ebp, ebp
	movaps	XMMWORD PTR 2464[rsp], xmm0
	movaps	XMMWORD PTR 2480[rsp], xmm0
	.p2align 4
	.p2align 3
.L10:
	mov	rdi, rbx
	call	XPending@PLT
	test	eax, eax
	je	.L148
.L11:
	mov	rsi, QWORD PTR [rsp]
	mov	rdi, rbx
	call	XNextEvent@PLT
	mov	rdi, rbx
	call	XPending@PLT
	test	eax, eax
	jne	.L11
.L148:
	mov	rdi, QWORD PTR 32[rsp]
	xor	esi, esi
	call	access@PLT
	test	eax, eax
	jne	.L12
	test	ebp, ebp
	jne	.L149
.L13:
	mov	ebp, DWORD PTR 20[rsp]
	test	ebp, ebp
	je	.L14
	cmp	BYTE PTR 227[rsp], 0
	je	.L14
	mov	rdi, QWORD PTR 112[rsp]
	call	xosd_hide@PLT
	mov	DWORD PTR 20[rsp], 0
.L14:
	mov	edi, 200000
	xor	ebp, ebp
	call	usleep@PLT
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L12:
	sub	rsp, 8
	.cfi_def_cfa_offset 7576
	mov	rdi, rbx
	push	QWORD PTR 176[rsp]
	.cfi_def_cfa_offset 7584
	push	QWORD PTR 176[rsp]
	.cfi_def_cfa_offset 7592
	push	QWORD PTR 176[rsp]
	.cfi_def_cfa_offset 7600
	mov	r9, QWORD PTR 176[rsp]
	mov	r8, QWORD PTR 168[rsp]
	mov	rcx, QWORD PTR 216[rsp]
	mov	rdx, QWORD PTR 208[rsp]
	mov	rsi, QWORD PTR 40[rsp]
	call	XQueryPointer@PLT
	add	rsp, 32
	.cfi_def_cfa_offset 7568
	test	eax, eax
	je	.L16
	mov	ebp, DWORD PTR 264[rsp]
	mov	r13d, DWORD PTR 268[rsp]
	cmp	ebp, DWORD PTR 228[rsp]
	jne	.L17
	cmp	DWORD PTR 248[rsp], r13d
	je	.L16
.L17:
	xor	edi, edi
	call	time@PLT
	mov	DWORD PTR 248[rsp], r13d
	mov	QWORD PTR 104[rsp], rax
	mov	DWORD PTR 228[rsp], ebp
.L16:
	xor	edi, edi
	call	time@PLT
	mov	QWORD PTR 304[rsp], rax
	sub	eax, DWORD PTR 104[rsp]
	mov	DWORD PTR 48[rsp], eax
	cmp	eax, 99
	jle	.L18
	mov	rdi, QWORD PTR 120[rsp]
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	call	open@PLT
	test	eax, eax
	js	.L19
	mov	edi, eax
	call	close@PLT
.L19:
	xor	esi, esi
	lea	rdi, .LC23[rip]
	xor	eax, eax
	call	open@PLT
	mov	ebp, eax
	test	eax, eax
	js	.L150
	mov	rsi, QWORD PTR 24[rsp]
	mov	edi, eax
	mov	edx, 31
	call	read@PLT
	mov	edi, ebp
	mov	r13, rax
	call	close@PLT
	test	r13, r13
	jle	.L151
	mov	BYTE PTR 3392[rsp+r13], 0
	mov	rdi, QWORD PTR 24[rsp]
	mov	edx, 10
	xor	esi, esi
	call	__isoc23_strtol@PLT
	xor	esi, esi
	lea	rdi, .LC24[rip]
	mov	r13d, eax
	xor	eax, eax
	call	open@PLT
	mov	ebp, eax
	test	eax, eax
	js	.L25
.L21:
	mov	r14, QWORD PTR 24[rsp]
	mov	edi, ebp
	mov	edx, 31
	mov	rsi, r14
	call	read@PLT
	mov	edi, ebp
	mov	r15, rax
	call	close@PLT
	test	r15, r15
	jle	.L25
	mov	BYTE PTR 3392[rsp+r15], 0
	mov	edx, 10
	xor	esi, esi
	mov	rdi, r14
	lea	r15, .LC1[rip]
	call	__isoc23_strtol@PLT
	cmp	eax, 1
	jne	.L25
.L22:
	mov	rsi, QWORD PTR 200[rsp]
	mov	rdi, QWORD PTR 192[rsp]
	call	localtime_r@PLT
	movsxd	rbp, DWORD PTR 360[rsp]
	mov	r9, r15
	mov	esi, 128
	lea	r8, .LC25[rip]
	mov	ecx, 128
	mov	rax, rbp
	imul	rbp, rbp, 715827883
	cdq
	sar	rbp, 33
	sub	ebp, edx
	lea	edx, 0[rbp+rbp*2]
	mov	ebp, eax
	sal	edx, 2
	sub	ebp, edx
	mov	edx, 12
	cmove	ebp, edx
	cmp	eax, 12
	lea	rdx, .LC7[rip]
	lea	rax, .LC6[rip]
	cmovge	rdx, rax
	sub	rsp, 8
	.cfi_def_cfa_offset 7576
	push	rdx
	.cfi_def_cfa_offset 7584
	mov	eax, DWORD PTR 368[rsp]
	mov	edx, 1
	push	rax
	.cfi_def_cfa_offset 7592
	mov	eax, DWORD PTR 380[rsp]
	push	rax
	.cfi_def_cfa_offset 7600
	xor	eax, eax
	push	rbp
	.cfi_def_cfa_offset 7608
	push	r13
	.cfi_def_cfa_offset 7616
	mov	rdi, QWORD PTR 88[rsp]
	call	__snprintf_chk@PLT
	add	rsp, 48
	.cfi_def_cfa_offset 7568
	mov	edx, 1
	mov	rdi, rbx
	lea	rsi, .LC26[rip]
	call	XInternAtom@PLT
	test	rax, rax
	je	.L31
	xor	r9d, r9d
	mov	r8d, 1024
	xor	ecx, ecx
	mov	rdx, rax
	mov	QWORD PTR 336[rsp], 0
	mov	rdi, rbx
	push	QWORD PTR 216[rsp]
	.cfi_def_cfa_offset 7576
	push	QWORD PTR 104[rsp]
	.cfi_def_cfa_offset 7584
	push	QWORD PTR 104[rsp]
	.cfi_def_cfa_offset 7592
	push	QWORD PTR 96[rsp]
	.cfi_def_cfa_offset 7600
	push	QWORD PTR 112[rsp]
	.cfi_def_cfa_offset 7608
	push	33
	.cfi_def_cfa_offset 7616
	mov	rsi, QWORD PTR 56[rsp]
	call	XGetWindowProperty@PLT
	add	rsp, 48
	.cfi_def_cfa_offset 7568
	test	eax, eax
	jne	.L31
	mov	r14, QWORD PTR 336[rsp]
	test	r14, r14
	je	.L152
	xor	r13d, r13d
	cmp	QWORD PTR 320[rsp], 0
	je	.L42
	mov	DWORD PTR 252[rsp], ebp
	mov	r15, QWORD PTR 208[rsp]
	.p2align 4
	.p2align 3
.L35:
	mov	rsi, QWORD PTR [r14+r13*8]
	mov	rdx, r15
	mov	rdi, rbx
	mov	QWORD PTR 344[rsp], 0
	call	XFetchName@PLT
	test	eax, eax
	jle	.L38
	mov	rbp, QWORD PTR 344[rsp]
	test	rbp, rbp
	je	.L38
	mov	rdi, rbp
	lea	rsi, .LC27[rip]
	call	strstr@PLT
	mov	rdi, rbp
	test	rax, rax
	jne	.L153
	call	XFree@PLT
.L38:
	add	r13, 1
	cmp	r13, QWORD PTR 320[rsp]
	jb	.L35
	mov	ebp, DWORD PTR 252[rsp]
	mov	r14, QWORD PTR 336[rsp]
.L42:
	mov	rdi, r14
	call	XFree@PLT
	.p2align 4
	.p2align 3
.L31:
	mov	rdi, QWORD PTR 128[rsp]
	xor	esi, esi
	xor	eax, eax
	call	open@PLT
	mov	r13d, eax
	test	eax, eax
	js	.L43
.L33:
	mov	rsi, QWORD PTR 24[rsp]
	mov	edi, r13d
	mov	edx, 4095
	call	read@PLT
	mov	edi, r13d
	mov	r15, rax
	call	close@PLT
	test	r15, r15
	jle	.L43
	mov	BYTE PTR 3392[rsp+r15], 0
	mov	rdi, QWORD PTR 24[rsp]
	lea	rsi, .LC28[rip]
	lea	r15, .LC10[rip]
	lea	r13, .LC11[rip]
	call	strstr@PLT
	test	rax, rax
	je	.L43
.L45:
	mov	rsi, r13
	mov	rdi, r12
	call	strcmp@PLT
	test	eax, eax
	jne	.L154
.L46:
	mov	r14, QWORD PTR 64[rsp]
	mov	rcx, QWORD PTR 40[rsp]
	mov	edx, 1
	xor	eax, eax
	mov	esi, 2
	mov	rdi, r14
	call	xosd_display@PLT
	mov	rdi, r14
	xor	eax, eax
	mov	rcx, r15
	mov	edx, 1
	mov	esi, 3
	call	xosd_display@PLT
	mov	rdi, r14
	call	xosd_show@PLT
	cmp	DWORD PTR 48[rsp], 99
	jle	.L48
	cmp	BYTE PTR 227[rsp], 0
	jne	.L155
.L48:
	mov	esi, DWORD PTR 20[rsp]
	test	esi, esi
	je	.L58
	cmp	BYTE PTR 227[rsp], 0
	je	.L58
	mov	rdi, QWORD PTR 112[rsp]
	call	xosd_hide@PLT
	mov	DWORD PTR 20[rsp], 0
.L58:
	mov	r9, QWORD PTR 72[rsp]
	mov	r8, QWORD PTR 96[rsp]
	mov	rdi, rbx
	mov	rcx, QWORD PTR 88[rsp]
	mov	rdx, QWORD PTR 80[rsp]
	mov	rsi, QWORD PTR 8[rsp]
	call	XQueryTree@PLT
	test	eax, eax
	je	.L60
	mov	ecx, DWORD PTR 284[rsp]
	mov	r13, QWORD PTR 216[rsp]
	xor	ebp, ebp
	test	ecx, ecx
	jne	.L61
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L156:
	call	XFree@PLT
	mov	rax, QWORD PTR 328[rsp]
	xor	edx, edx
	mov	rdi, rbx
	lea	rsi, .LC31[rip]
	mov	r14, QWORD PTR [rax+rbp*8]
	call	XInternAtom@PLT
	xor	edx, edx
	lea	rsi, .LC32[rip]
	mov	rdi, rbx
	movq	xmm1, rax
	movq	xmm0, r14
	punpcklqdq	xmm0, xmm1
	movaps	XMMWORD PTR 48[rsp], xmm0
	call	XInternAtom@PLT
	xor	edx, edx
	lea	rsi, .LC33[rip]
	mov	rdi, rbx
	mov	r15, rax
	call	XInternAtom@PLT
	mov	rdx, rax
	mov	rax, QWORD PTR 232[rsp]
	mov	QWORD PTR [rax], 0
	mov	rdi, QWORD PTR 240[rsp]
	mov	QWORD PTR 600[rsp], 0
	and	rdi, -8
	sub	rax, rdi
	lea	ecx, 188[rax]
	xor	eax, eax
	shr	ecx, 3
	rep stosq
	mov	QWORD PTR 488[rsp], rdx
	mov	rdi, rbx
	xor	edx, edx
	mov	ecx, 1572864
	mov	DWORD PTR 416[rsp], 33
	movdqa	xmm0, XMMWORD PTR 48[rsp]
	mov	r8, QWORD PTR [rsp]
	mov	DWORD PTR 464[rsp], 32
	mov	rsi, QWORD PTR 8[rsp]
	mov	QWORD PTR 472[rsp], 1
	movaps	XMMWORD PTR 448[rsp], xmm0
	mov	QWORD PTR 480[rsp], r15
	mov	QWORD PTR 496[rsp], 1
	call	XSendEvent@PLT
	xor	edx, edx
	lea	rsi, .LC34[rip]
	mov	rdi, rbx
	call	XInternAtom@PLT
	mov	ecx, 4294967295
	xor	r9d, r9d
	mov	rsi, r14
	mov	QWORD PTR 344[rsp], rcx
	mov	rdx, rax
	mov	r8d, 32
	mov	rdi, rbx
	push	1
	.cfi_def_cfa_offset 7576
	mov	ecx, 6
	push	QWORD PTR 216[rsp]
	.cfi_def_cfa_offset 7584
	call	XChangeProperty@PLT
	mov	rax, QWORD PTR 344[rsp]
	mov	rdi, rbx
	mov	rsi, QWORD PTR [rax+rbp*8]
	call	XMapWindow@PLT
	mov	rax, QWORD PTR 344[rsp]
	mov	rdi, rbx
	mov	rsi, QWORD PTR [rax+rbp*8]
	call	XRaiseWindow@PLT
	pop	rax
	.cfi_def_cfa_offset 7576
	pop	rdx
	.cfi_def_cfa_offset 7568
.L64:
	add	rbp, 1
	cmp	ebp, DWORD PTR 284[rsp]
	jnb	.L66
.L61:
	mov	rax, QWORD PTR 328[rsp]
	mov	rdx, r13
	mov	rdi, rbx
	mov	QWORD PTR 336[rsp], 0
	mov	rsi, QWORD PTR [rax+rbp*8]
	call	XFetchName@PLT
	test	eax, eax
	jle	.L64
	mov	r14, QWORD PTR 336[rsp]
	test	r14, r14
	je	.L64
	mov	rdi, r14
	lea	rsi, .LC30[rip]
	call	strcmp@PLT
	mov	rdi, r14
	test	eax, eax
	je	.L156
	call	XFree@PLT
	add	rbp, 1
	cmp	ebp, DWORD PTR 284[rsp]
	jb	.L61
	.p2align 4
	.p2align 3
.L66:
	mov	rdi, QWORD PTR 328[rsp]
	test	rdi, rdi
	je	.L60
	call	XFree@PLT
.L60:
	mov	edi, 100000
	mov	ebp, 1
	call	usleep@PLT
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L18:
	mov	rdi, QWORD PTR 120[rsp]
	call	unlink@PLT
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L150:
	xor	esi, esi
	lea	rdi, .LC24[rip]
	xor	eax, eax
	xor	r13d, r13d
	call	open@PLT
	mov	ebp, eax
	test	eax, eax
	jns	.L21
.L24:
	xor	r13d, r13d
	lea	r15, .LC5[rip]
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L25:
	lea	r15, .LC2[rip]
	cmp	r13d, 84
	jg	.L22
	lea	r15, .LC3[rip]
	cmp	r13d, 39
	jg	.L22
	cmp	r13d, 14
	jle	.L76
	lea	r15, .LC4[rip]
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L149:
	mov	rdi, QWORD PTR 64[rsp]
	call	xosd_hide@PLT
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L154:
	mov	rdi, QWORD PTR 64[rsp]
	mov	rsi, r13
	call	xosd_set_colour@PLT
	mov	rax, QWORD PTR 112[rsp]
	test	rax, rax
	je	.L47
	mov	rsi, r13
	mov	rdi, rax
	call	xosd_set_colour@PLT
.L47:
	mov	edx, 31
	mov	rsi, r13
	mov	rdi, r12
	call	strncpy@PLT
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L151:
	xor	esi, esi
	lea	rdi, .LC24[rip]
	xor	eax, eax
	xor	r13d, r13d
	call	open@PLT
	mov	ebp, eax
	test	eax, eax
	jns	.L21
	jmp	.L24
	.p2align 4,,10
	.p2align 3
.L155:
	mov	eax, DWORD PTR 352[rsp]
	mov	r9d, ebp
	mov	ecx, 16
	lea	r8, .LC29[rip]
	mov	edx, 1
	mov	esi, 16
	push	rax
	.cfi_def_cfa_offset 7576
	mov	eax, DWORD PTR 364[rsp]
	push	rax
	.cfi_def_cfa_offset 7584
	mov	r14, QWORD PTR 40[rsp]
	xor	eax, eax
	mov	rdi, r14
	call	__snprintf_chk@PLT
	movsx	eax, BYTE PTR 3408[rsp]
	mov	BYTE PTR 432[rsp], 0
	mov	BYTE PTR 688[rsp], 0
	mov	BYTE PTR 944[rsp], 0
	mov	BYTE PTR 1200[rsp], 0
	mov	BYTE PTR 1456[rsp], 0
	mov	BYTE PTR 1712[rsp], 0
	mov	BYTE PTR 1968[rsp], 0
	mov	BYTE PTR 2224[rsp], 0
	pop	r10
	.cfi_def_cfa_offset 7576
	pop	r11
	.cfi_def_cfa_offset 7568
	test	al, al
	je	.L49
	mov	r13, QWORD PTR [rsp]
	.p2align 4
	.p2align 3
.L50:
	lea	edx, -48[rax]
	cmp	dl, 9
	jbe	.L157
	cmp	al, 58
	je	.L53
	mov	rbp, r13
	.p2align 4
	.p2align 3
.L54:
	mov	rdi, rbp
	add	rbp, 256
	call	strlen@PLT
	mov	r8d, 32
	mov	WORD PTR -256[rbp+rax], r8w
	cmp	rbp, r12
	jne	.L54
	movsx	eax, BYTE PTR 1[r14]
	add	r14, 1
	test	al, al
	jne	.L50
.L49:
	mov	r13, QWORD PTR [rsp]
	mov	r14, QWORD PTR 112[rsp]
	xor	ebp, ebp
	.p2align 4
	.p2align 3
.L57:
	mov	rcx, rbp
	mov	esi, ebp
	mov	edx, 1
	mov	rdi, r14
	sal	rcx, 8
	xor	eax, eax
	add	rbp, 1
	add	rcx, r13
	call	xosd_display@PLT
	cmp	rbp, 8
	jne	.L57
	mov	rdi, QWORD PTR 112[rsp]
	call	xosd_show@PLT
	mov	DWORD PTR 20[rsp], 1
	jmp	.L58
	.p2align 4,,10
	.p2align 3
.L157:
	lea	r15d, -48[rax]
	lea	rax, ascii_v[rip]
	mov	rbp, r13
	sal	r15, 6
	add	r15, rax
	.p2align 4
	.p2align 3
.L51:
	mov	rdi, rbp
	add	r15, 8
	call	strlen@PLT
	mov	rsi, QWORD PTR -8[r15]
	lea	rdi, 0[rbp+rax]
	add	rbp, 256
	call	stpcpy@PLT
	mov	r9d, 32
	mov	WORD PTR [rax], r9w
	cmp	rbp, r12
	jne	.L51
	movsx	eax, BYTE PTR 1[r14]
	add	r14, 1
	test	al, al
	jne	.L50
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L53:
	lea	r15, ascii_colon[rip]
	mov	rbp, r13
	.p2align 4
	.p2align 3
.L56:
	mov	rdi, rbp
	add	r15, 8
	call	strlen@PLT
	mov	rsi, QWORD PTR -8[r15]
	lea	rdi, 0[rbp+rax]
	add	rbp, 256
	call	stpcpy@PLT
	mov	edi, 32
	mov	WORD PTR [rax], di
	lea	rax, ascii_colon[rip+64]
	cmp	r15, rax
	jne	.L56
	movsx	eax, BYTE PTR 1[r14]
	add	r14, 1
	test	al, al
	jne	.L50
	jmp	.L49
.L152:
	mov	rdi, QWORD PTR 128[rsp]
	xor	esi, esi
	call	open@PLT
	mov	r13d, eax
	test	eax, eax
	jns	.L33
	.p2align 4
	.p2align 3
.L43:
	lea	r15, .LC12[rip]
	lea	r13, .LC13[rip]
	jmp	.L45
.L153:
	mov	ebp, DWORD PTR 252[rsp]
	call	XFree@PLT
	mov	rdi, QWORD PTR 336[rsp]
	call	XFree@PLT
	mov	rdi, QWORD PTR 128[rsp]
	xor	esi, esi
	xor	eax, eax
	call	open@PLT
	mov	r13d, eax
	test	eax, eax
	js	.L40
	mov	rsi, QWORD PTR 24[rsp]
	mov	edi, eax
	mov	edx, 4095
	call	read@PLT
	mov	edi, r13d
	call	close@PLT
.L40:
	lea	r15, .LC8[rip]
	lea	r13, .LC9[rip]
	jmp	.L45
.L146:
	mov	rcx, QWORD PTR stderr[rip]
	mov	edx, 33
	mov	esi, 1
	lea	rdi, .LC19[rip]
	call	fwrite@PLT
.L7:
	mov	rax, QWORD PTR 7496[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L158
	add	rsp, 7512
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
.L147:
	.cfi_restore_state
	mov	rcx, QWORD PTR stderr[rip]
	mov	edx, 34
	mov	esi, 1
	lea	rdi, .LC20[rip]
	call	fwrite@PLT
	mov	rdi, rbx
	call	XCloseDisplay@PLT
	jmp	.L7
.L158:
	call	__stack_chk_fail@PLT
.L76:
	lea	r15, .LC5[rip]
	jmp	.L22
	.cfi_endproc
.LFE86:
	.size	main, .-main
	.section	.rodata.str1.1
.LC35:
	.string	"    "
.LC36:
	.string	" /$$"
.LC37:
	.string	"|__/"
	.section	.data.rel.ro.local,"aw"
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
	.section	.data.rel.ro.local
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
	.ident	"GCC: (Gentoo 15.2.1_p20260214 p5) 15.2.1 20260214"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
