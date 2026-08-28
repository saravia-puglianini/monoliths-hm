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
	.string	"AC"
.LC3:
	.string	"[=--]"
.LC4:
	.string	"[---]"
.LC5:
	.string	"[===]"
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
	.align 8
.LC25:
	.string	"/sys/class/power_supply/BAT0/status"
	.section	.rodata.str1.1
.LC26:
	.string	"Discharging"
.LC27:
	.string	"%s %d%% %02d:%02d:%02d %s"
.LC28:
	.string	"%d de %s del %d"
.LC29:
	.string	"_NET_CLIENT_LIST"
.LC30:
	.string	"ctrl+shift releases"
.LC31:
	.string	"NOT MOUSE"
.LC32:
	.string	""
.LC33:
	.string	"%02d:%02d:%02d"
.LC34:
	.string	"XOSD"
.LC35:
	.string	"_NET_WM_STATE"
.LC36:
	.string	"_NET_WM_STATE_STICKY"
.LC37:
	.string	"_NET_WM_STATE_ABOVE"
.LC38:
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
	sub	rsp, 5528
	.cfi_def_cfa_offset 5584
	call	getenv
	mov	edx, OFFSET FLAT:.LC15
	mov	esi, 256
	lea	rdi, [rsp+656]
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
	lea	rdi, [rsp+912]
	call	snprintf
	mov	edx, OFFSET FLAT:.LC17
	xor	eax, eax
	mov	rcx, rbx
	mov	esi, 256
	lea	rdi, [rsp+1168]
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
	je	.L145
	mov	edi, OFFSET FLAT:x11_silent_error_handler
	call	XSetErrorHandler
	movsx	rax, DWORD PTR [rbx+224]
	mov	edi, 6
	sal	rax, 7
	add	rax, QWORD PTR [rbx+232]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rsp+8], rax
	call	xosd_create
	mov	r12, rax
	test	rax, rax
	je	.L146
	xor	esi, esi
	mov	rdi, rax
	call	xosd_set_pos
	mov	esi, 2
	mov	rdi, r12
	call	xosd_set_align
	mov	esi, 50
	mov	rdi, r12
	call	xosd_set_horizontal_offset
	mov	esi, 1
	mov	rdi, r12
	call	xosd_set_shadow_offset
	mov	esi, -1
	mov	rdi, r12
	call	xosd_set_timeout
	mov	edi, 8
	call	xosd_create
	mov	r15, rax
	mov	QWORD PTR [rsp+16], rax
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
	call	setenv
	call	tzset
	xor	edi, edi
	call	time
	pxor	xmm0, xmm0
	mov	QWORD PTR [rsp+32], rax
	mov	eax, -1
	mov	DWORD PTR [rsp+44], eax
	mov	DWORD PTR [rsp+40], eax
	lea	rax, [rsp+1428]
	mov	QWORD PTR [rsp+56], rax
	movaps	XMMWORD PTR [rsp+160], xmm0
	movaps	XMMWORD PTR [rsp+176], xmm0
	.p2align 4,,10
	.p2align 3
.L10:
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	je	.L147
.L11:
	mov	rdi, rbx
	lea	rsi, [rsp+1424]
	call	XNextEvent
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	jne	.L11
.L147:
	xor	esi, esi
	lea	rdi, [rsp+656]
	call	access
	test	eax, eax
	jne	.L12
	test	ebp, ebp
	jne	.L148
.L13:
	test	r15d, r15d
	je	.L14
	mov	rax, QWORD PTR [rsp+16]
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
	.cfi_def_cfa_offset 5592
	mov	rdi, rbx
	lea	rax, [rsp+96]
	push	rax
	.cfi_def_cfa_offset 5600
	lea	rax, [rsp+100]
	push	rax
	.cfi_def_cfa_offset 5608
	lea	rax, [rsp+104]
	push	rax
	.cfi_def_cfa_offset 5616
	mov	rsi, QWORD PTR [rsp+40]
	lea	r9, [rsp+108]
	lea	r8, [rsp+104]
	lea	rcx, [rsp+136]
	lea	rdx, [rsp+128]
	call	XQueryPointer
	add	rsp, 32
	.cfi_def_cfa_offset 5584
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
	setg	BYTE PTR [rsp+24]
	jle	.L18
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	lea	rdi, [rsp+1168]
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
	lea	rsi, [rsp+1424]
	call	read
	mov	edi, ebp
	mov	r13, rax
	call	close
	test	r13, r13
	jle	.L22
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1424]
	mov	BYTE PTR [rsp+1424+r13], 0
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
	lea	rsi, [rsp+1424]
	call	read
	mov	edi, ebp
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L24
	xor	esi, esi
	mov	edx, 10
	lea	rdi, [rsp+1424]
	mov	BYTE PTR [rsp+1424+r14], 0
	call	strtol
	cmp	eax, 1
	jne	.L24
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC25
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L142
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1424]
	call	read
	mov	edi, ebp
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L142
	mov	esi, OFFSET FLAT:.LC26
	lea	rdi, [rsp+1424]
	mov	BYTE PTR [rsp+1424+r14], 0
	call	strstr
	test	rax, rax
	je	.L142
	.p2align 4,,10
	.p2align 3
.L24:
	mov	r14d, OFFSET FLAT:.LC5
	cmp	r13d, 84
	jg	.L28
	mov	r14d, OFFSET FLAT:.LC1
	cmp	r13d, 39
	jg	.L28
	cmp	r13d, 14
	mov	r14d, OFFSET FLAT:.LC3
	mov	eax, OFFSET FLAT:.LC4
	cmovle	r14, rax
	.p2align 4,,10
	.p2align 3
.L28:
	lea	rsi, [rsp+192]
	lea	rdi, [rsp+112]
	call	localtime_r
	mov	ecx, DWORD PTR [rsp+200]
	mov	edx, 715827883
	mov	r8d, r13d
	mov	esi, 128
	mov	eax, ecx
	mov	ebp, ecx
	imul	edx
	mov	eax, ecx
	sar	eax, 31
	sar	edx
	sub	edx, eax
	lea	eax, [rdx+rdx*2]
	mov	edx, OFFSET FLAT:.LC7
	sal	eax, 2
	sub	ebp, eax
	mov	eax, 12
	cmove	ebp, eax
	cmp	ecx, 11
	mov	eax, OFFSET FLAT:.LC6
	mov	rcx, r14
	cmovle	rax, rdx
	sub	rsp, 8
	.cfi_def_cfa_offset 5592
	mov	edx, OFFSET FLAT:.LC27
	mov	r9d, ebp
	push	rax
	.cfi_def_cfa_offset 5600
	mov	eax, DWORD PTR [rsp+208]
	push	rax
	.cfi_def_cfa_offset 5608
	mov	eax, DWORD PTR [rsp+220]
	push	rax
	.cfi_def_cfa_offset 5616
	xor	eax, eax
	lea	rdi, [rsp+288]
	call	snprintf
	add	rsp, 32
	.cfi_def_cfa_offset 5584
	movsx	rax, DWORD PTR [rsp+208]
	mov	edx, DWORD PTR [rsp+212]
	mov	ecx, DWORD PTR [rsp+204]
	mov	esi, 128
	lea	rdi, [rsp+384]
	mov	r8, QWORD PTR months_es[0+rax*8]
	lea	r9d, [rdx+1900]
	xor	eax, eax
	mov	edx, OFFSET FLAT:.LC28
	call	snprintf
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC29
	mov	rdi, rbx
	call	XInternAtom
	test	rax, rax
	je	.L39
	xor	r9d, r9d
	mov	r8d, 1024
	mov	rdx, rax
	mov	rdi, rbx
	lea	rcx, [rsp+512]
	mov	QWORD PTR [rsp+512], 0
	push	rcx
	.cfi_def_cfa_offset 5592
	lea	rcx, [rsp+160]
	push	rcx
	.cfi_def_cfa_offset 5600
	lea	rcx, [rsp+160]
	push	rcx
	.cfi_def_cfa_offset 5608
	lea	rcx, [rsp+152]
	push	rcx
	.cfi_def_cfa_offset 5616
	lea	rcx, [rsp+168]
	push	rcx
	.cfi_def_cfa_offset 5624
	xor	ecx, ecx
	push	33
	.cfi_def_cfa_offset 5632
	mov	rsi, QWORD PTR [rsp+56]
	call	XGetWindowProperty
	add	rsp, 48
	.cfi_def_cfa_offset 5584
	test	eax, eax
	jne	.L39
	mov	r13, QWORD PTR [rsp+512]
	test	r13, r13
	je	.L39
	cmp	QWORD PTR [rsp+144], 0
	je	.L33
	mov	DWORD PTR [rsp+48], ebp
	xor	r14d, r14d
	.p2align 4,,10
	.p2align 3
.L38:
	mov	rsi, QWORD PTR [r13+0+r14*8]
	mov	rdi, rbx
	lea	rdx, [rsp+1424]
	mov	QWORD PTR [rsp+1424], 0
	call	XFetchName
	test	eax, eax
	jle	.L34
	mov	rbp, QWORD PTR [rsp+1424]
	test	rbp, rbp
	je	.L34
	mov	esi, OFFSET FLAT:.LC30
	mov	rdi, rbp
	call	strstr
	test	rax, rax
	jne	.L149
	mov	rdi, rbp
	call	XFree
.L34:
	add	r14, 1
	cmp	r14, QWORD PTR [rsp+144]
	jb	.L38
	mov	ebp, DWORD PTR [rsp+48]
	mov	r13, QWORD PTR [rsp+512]
.L33:
	mov	rdi, r13
	call	XFree
	.p2align 4,,10
	.p2align 3
.L39:
	xor	esi, esi
	lea	rdi, [rsp+912]
	xor	eax, eax
	call	open
	mov	r13d, eax
	test	eax, eax
	js	.L66
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1424]
	call	read
	mov	edi, r13d
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L66
	mov	esi, OFFSET FLAT:.LC31
	lea	rdi, [rsp+1424]
	mov	BYTE PTR [rsp+1424+r14], 0
	mov	r13d, OFFSET FLAT:.LC13
	call	strstr
	mov	r14d, OFFSET FLAT:.LC12
	mov	edx, OFFSET FLAT:.LC8
	test	rax, rax
	mov	eax, OFFSET FLAT:.LC9
	cmove	r14, rdx
	cmove	r13, rax
.L40:
	lea	rdi, [rsp+160]
	mov	rsi, r13
	call	strcmp
	test	eax, eax
	jne	.L150
.L41:
	movsx	rax, DWORD PTR [rsp+216]
	xor	esi, esi
	mov	edx, 1
	mov	rdi, r12
	mov	rcx, QWORD PTR weekdays_es[0+rax*8]
	xor	eax, eax
	call	xosd_display
	mov	ecx, OFFSET FLAT:.LC32
	mov	rdi, r12
	xor	eax, eax
	mov	edx, 1
	mov	esi, 1
	call	xosd_display
	mov	edx, 1
	mov	rdi, r12
	xor	eax, eax
	lea	rcx, [rsp+384]
	mov	esi, 2
	call	xosd_display
	mov	ecx, OFFSET FLAT:.LC32
	mov	rdi, r12
	xor	eax, eax
	mov	edx, 1
	mov	esi, 3
	call	xosd_display
	mov	edx, 1
	mov	rdi, r12
	xor	eax, eax
	lea	rcx, [rsp+256]
	mov	esi, 4
	call	xosd_display
	mov	rcx, r14
	mov	edx, 1
	mov	rdi, r12
	mov	esi, 5
	xor	eax, eax
	call	xosd_display
	mov	rdi, r12
	call	xosd_show
	cmp	QWORD PTR [rsp+16], 0
	setne	al
	cmp	BYTE PTR [rsp+24], 0
	je	.L43
	test	al, al
	jne	.L151
.L43:
	test	r15d, r15d
	je	.L54
	test	al, al
	je	.L54
	mov	rdi, QWORD PTR [rsp+16]
	xor	r15d, r15d
	call	xosd_hide
.L54:
	mov	rsi, QWORD PTR [rsp+8]
	lea	r9, [rsp+92]
	mov	rdi, rbx
	lea	r8, [rsp+136]
	lea	rcx, [rsp+128]
	lea	rdx, [rsp+120]
	call	XQueryTree
	test	eax, eax
	je	.L56
	mov	esi, DWORD PTR [rsp+92]
	mov	rdi, QWORD PTR [rsp+136]
	test	esi, esi
	je	.L57
	xor	ebp, ebp
	jmp	.L64
	.p2align 4,,10
	.p2align 3
.L58:
	mov	rax, QWORD PTR [rsp+144]
	test	rax, rax
	je	.L144
	mov	edi, OFFSET FLAT:.LC34
	mov	ecx, 5
	mov	rsi, rax
	repz cmpsb
	mov	rdi, rax
	seta	dl
	sbb	dl, 0
	test	dl, dl
	jne	.L61
	call	XFree
	mov	rax, QWORD PTR [rsp+136]
	mov	rdi, rbx
	lea	rdx, [rsp+512]
	mov	rsi, QWORD PTR [rax+r13*8]
	call	XGetWindowAttributes
	mov	rdi, QWORD PTR [rsp+136]
	test	eax, eax
	je	.L59
	mov	ecx, DWORD PTR [rsp+604]
	test	ecx, ecx
	jne	.L152
.L59:
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+92]
	jnb	.L57
	.p2align 4,,10
	.p2align 3
.L64:
	mov	r13d, ebp
	lea	rdx, [rsp+144]
	mov	QWORD PTR [rsp+144], 0
	mov	rsi, QWORD PTR [rdi+r13*8]
	mov	rdi, rbx
	call	XFetchName
	test	eax, eax
	jg	.L58
.L144:
	mov	rdi, QWORD PTR [rsp+136]
.L153:
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+92]
	jb	.L64
.L57:
	test	rdi, rdi
	je	.L56
	call	XFree
.L56:
	mov	edi, 100000
	mov	ebp, 1
	call	usleep
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L61:
	call	XFree
	mov	rdi, QWORD PTR [rsp+136]
	jmp	.L153
	.p2align 4,,10
	.p2align 3
.L22:
	xor	r13d, r13d
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L18:
	lea	rdi, [rsp+1168]
	call	unlink
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L148:
	mov	rdi, r12
	call	xosd_hide
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L150:
	mov	rsi, r13
	mov	rdi, r12
	call	xosd_set_colour
	mov	rax, QWORD PTR [rsp+16]
	test	rax, rax
	je	.L42
	mov	rsi, r13
	mov	rdi, rax
	call	xosd_set_colour
.L42:
	mov	edx, 31
	mov	rsi, r13
	lea	rdi, [rsp+160]
	call	strncpy
	jmp	.L41
	.p2align 4,,10
	.p2align 3
.L66:
	mov	r14d, OFFSET FLAT:.LC8
	mov	r13d, OFFSET FLAT:.LC9
	jmp	.L40
	.p2align 4,,10
	.p2align 3
.L151:
	mov	ecx, ebp
	mov	edx, OFFSET FLAT:.LC33
	mov	esi, 16
	xor	eax, eax
	mov	r9d, DWORD PTR [rsp+192]
	mov	r8d, DWORD PTR [rsp+196]
	lea	rdi, [rsp+512]
	lea	r14, [rsp+513]
	call	snprintf
	mov	BYTE PTR [rsp+1424], 0
	movsx	r13, BYTE PTR [rsp+512]
	lea	rax, [rsp+3472]
	mov	BYTE PTR [rsp+1680], 0
	mov	BYTE PTR [rsp+1936], 0
	mov	BYTE PTR [rsp+2192], 0
	mov	BYTE PTR [rsp+2448], 0
	mov	BYTE PTR [rsp+2704], 0
	mov	BYTE PTR [rsp+2960], 0
	mov	BYTE PTR [rsp+3216], 0
	test	r13b, r13b
	je	.L53
	mov	QWORD PTR [rsp+24], rbx
	mov	r15, rax
	.p2align 4,,10
	.p2align 3
.L52:
	lea	eax, [r13-48]
	cmp	al, 9
	jbe	.L46
	xor	ebx, ebx
	.p2align 4,,10
	.p2align 3
.L50:
	mov	rbp, rbx
	lea	rax, [rsp+1424]
	sal	rbp, 8
	add	rbp, rax
	mov	rdi, rbp
	cmp	r13b, 58
	je	.L154
	call	strlen
	add	rbx, 1
	mov	r8d, 32
	mov	WORD PTR [rbp+0+rax], r8w
	cmp	rbx, 8
	jne	.L50
	add	r14, 1
	movsx	r13, BYTE PTR [r14-1]
	test	r13b, r13b
	jne	.L52
.L155:
	mov	rbx, QWORD PTR [rsp+24]
.L53:
	mov	r13, QWORD PTR [rsp+16]
	xor	ebp, ebp
	.p2align 4,,10
	.p2align 3
.L45:
	mov	rcx, rbp
	lea	rax, [rsp+1424]
	mov	esi, ebp
	mov	rdi, r13
	sal	rcx, 8
	mov	edx, 1
	add	rbp, 1
	add	rcx, rax
	xor	eax, eax
	call	xosd_display
	cmp	rbp, 8
	jne	.L45
	mov	rdi, QWORD PTR [rsp+16]
	mov	r15d, 1
	call	xosd_show
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L154:
	call	strlen
	mov	rsi, QWORD PTR ascii_colon[0+rbx*8]
	add	rbx, 1
	lea	rdi, [rbp+0+rax]
	call	stpcpy
	mov	r9d, 32
	mov	WORD PTR [rax], r9w
	cmp	rbx, 8
	jne	.L50
	add	r14, 1
	movsx	r13, BYTE PTR [r14-1]
	test	r13b, r13b
	jne	.L52
	jmp	.L155
	.p2align 4,,10
	.p2align 3
.L46:
	sal	r13, 6
	lea	rbp, [rsp+1424]
	add	r13, OFFSET FLAT:ascii_v-3072
	.p2align 4,,10
	.p2align 3
.L51:
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
	jne	.L51
	add	r14, 1
	movsx	r13, BYTE PTR [r14-1]
	test	r13b, r13b
	jne	.L52
	jmp	.L155
	.p2align 4,,10
	.p2align 3
.L142:
	mov	r14d, OFFSET FLAT:.LC2
	jmp	.L28
.L152:
	mov	rax, QWORD PTR [rdi+r13*8]
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC35
	mov	rdi, rbx
	mov	QWORD PTR [rsp+24], rax
	call	XInternAtom
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC36
	mov	rdi, rbx
	mov	QWORD PTR [rsp+48], rax
	call	XInternAtom
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC37
	mov	rdi, rbx
	mov	r14, rax
	call	XInternAtom
	lea	rdi, [rsp+1432]
	lea	r8, [rsp+1424]
	mov	rdx, rax
	mov	rax, QWORD PTR [rsp+56]
	mov	QWORD PTR [rax], 0
	sub	rax, rdi
	mov	QWORD PTR [rsp+1608], 0
	mov	rcx, rax
	xor	eax, eax
	add	ecx, 188
	shr	ecx, 3
	rep stosq
	mov	QWORD PTR [rsp+1496], rdx
	mov	rdi, rbx
	xor	edx, edx
	mov	ecx, 1572864
	mov	DWORD PTR [rsp+1424], 33
	movq	xmm0, QWORD PTR [rsp+24]
	mov	rsi, QWORD PTR [rsp+8]
	mov	DWORD PTR [rsp+1472], 32
	mov	QWORD PTR [rsp+1480], 1
	mov	QWORD PTR [rsp+1488], r14
	mov	QWORD PTR [rsp+1504], 1
	movhps	xmm0, QWORD PTR [rsp+48]
	movaps	XMMWORD PTR [rsp+1456], xmm0
	call	XSendEvent
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC38
	mov	rdi, rbx
	call	XInternAtom
	mov	ecx, 4294967295
	xor	r9d, r9d
	mov	rdi, rbx
	mov	QWORD PTR [rsp+152], rcx
	mov	rdx, rax
	mov	r8d, 32
	push	1
	.cfi_def_cfa_offset 5592
	lea	rcx, [rsp+160]
	push	rcx
	.cfi_def_cfa_offset 5600
	mov	rsi, QWORD PTR [rsp+40]
	mov	ecx, 6
	call	XChangeProperty
	mov	rax, QWORD PTR [rsp+152]
	mov	rdi, rbx
	mov	rsi, QWORD PTR [rax+r13*8]
	call	XRaiseWindow
	mov	rdi, QWORD PTR [rsp+152]
	pop	rax
	.cfi_def_cfa_offset 5592
	pop	rdx
	.cfi_def_cfa_offset 5584
	jmp	.L59
.L149:
	mov	rdx, rbp
	mov	ebp, DWORD PTR [rsp+48]
	mov	rdi, rdx
	call	XFree
	mov	rdi, QWORD PTR [rsp+512]
	call	XFree
	xor	esi, esi
	lea	rdi, [rsp+912]
	xor	eax, eax
	call	open
	mov	r13d, eax
	test	eax, eax
	jns	.L156
.L143:
	mov	r14d, OFFSET FLAT:.LC10
	mov	r13d, OFFSET FLAT:.LC11
	jmp	.L40
.L145:
	mov	edx, 33
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC19
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
.L134:
	add	rsp, 5528
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
.L146:
	.cfi_restore_state
	mov	edx, 34
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC20
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	mov	rdi, rbx
	call	XCloseDisplay
	jmp	.L134
.L156:
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1424]
	call	read
	mov	edi, r13d
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L143
	mov	BYTE PTR [rsp+1424+r14], 0
	jmp	.L143
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.str1.1
.LC39:
	.string	"ENERO"
.LC40:
	.string	"FEBRERO"
.LC41:
	.string	"MARZO"
.LC42:
	.string	"ABRIL"
.LC43:
	.string	"MAYO"
.LC44:
	.string	"JUNIO"
.LC45:
	.string	"JULIO"
.LC46:
	.string	"AGOSTO"
.LC47:
	.string	"SEPTIEMBRE"
.LC48:
	.string	"OCTUBRE"
.LC49:
	.string	"NOVIEMBRE"
.LC50:
	.string	"DICIEMBRE"
	.section	.rodata
	.align 32
	.type	months_es, @object
	.size	months_es, 96
months_es:
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
	.quad	.LC50
	.section	.rodata.str1.1
.LC51:
	.string	"DOMINGO"
.LC52:
	.string	"LUNES"
.LC53:
	.string	"MARTES"
.LC54:
	.string	"MIERCOLES"
.LC55:
	.string	"JUEVES"
.LC56:
	.string	"VIERNES"
.LC57:
	.string	"SABADO"
	.section	.rodata
	.align 32
	.type	weekdays_es, @object
	.size	weekdays_es, 56
weekdays_es:
	.quad	.LC51
	.quad	.LC52
	.quad	.LC53
	.quad	.LC54
	.quad	.LC55
	.quad	.LC56
	.quad	.LC57
	.section	.rodata.str1.1
.LC58:
	.string	"    "
.LC59:
	.string	" /$$"
.LC60:
	.string	"|__/"
	.section	.rodata
	.align 32
	.type	ascii_colon, @object
	.size	ascii_colon, 64
ascii_colon:
	.quad	.LC58
	.quad	.LC59
	.quad	.LC60
	.quad	.LC58
	.quad	.LC59
	.quad	.LC60
	.quad	.LC58
	.quad	.LC58
	.section	.rodata.str1.1
.LC61:
	.string	"  /$$$$$$ "
.LC62:
	.string	" /$$$_  $$"
.LC63:
	.string	"| $$$$\\ $$"
.LC64:
	.string	"| $$ $$ $$"
.LC65:
	.string	"| $$\\ $$$$"
.LC66:
	.string	"| $$ \\ $$$"
.LC67:
	.string	"|  $$$$$$/"
.LC68:
	.string	" \\______/ "
.LC69:
	.string	"   /$$  "
.LC70:
	.string	" /$$$$  "
.LC71:
	.string	"|_  $$  "
.LC72:
	.string	"  | $$  "
.LC73:
	.string	" /$$$$$$"
.LC74:
	.string	"|______/"
.LC75:
	.string	" /$$__  $$"
.LC76:
	.string	"|__/  \\ $$"
.LC77:
	.string	"  /$$$$$$/"
.LC78:
	.string	" /$$____/ "
.LC79:
	.string	"| $$      "
.LC80:
	.string	"| $$$$$$$$"
.LC81:
	.string	"|________/"
.LC82:
	.string	"   /$$$$$/"
.LC83:
	.string	"  |___  $$"
.LC84:
	.string	" /$$  \\ $$"
.LC85:
	.string	" /$$   /$$"
.LC86:
	.string	"| $$  | $$"
.LC87:
	.string	"|_____  $$"
.LC88:
	.string	"      | $$"
.LC89:
	.string	"      |__/"
.LC90:
	.string	" /$$$$$$$ "
.LC91:
	.string	"| $$____/ "
.LC92:
	.string	"| $$$$$$$ "
.LC93:
	.string	"| $$  \\__/"
.LC94:
	.string	"| $$__  $$"
.LC95:
	.string	"| $$  \\ $$"
.LC96:
	.string	" /$$$$$$$$"
.LC97:
	.string	"|_____ $$/"
.LC98:
	.string	"     /$$/ "
.LC99:
	.string	"    /$$/  "
.LC100:
	.string	"   /$$/   "
.LC101:
	.string	"  /$$/    "
.LC102:
	.string	" /$$/     "
.LC103:
	.string	"|__/      "
.LC104:
	.string	" >$$__  $$"
.LC105:
	.string	"|  $$$$$$$"
.LC106:
	.string	" \\____  $$"
	.section	.rodata
	.align 32
	.type	ascii_v, @object
	.size	ascii_v, 640
ascii_v:
	.quad	.LC61
	.quad	.LC62
	.quad	.LC63
	.quad	.LC64
	.quad	.LC65
	.quad	.LC66
	.quad	.LC67
	.quad	.LC68
	.quad	.LC69
	.quad	.LC70
	.quad	.LC71
	.quad	.LC72
	.quad	.LC72
	.quad	.LC72
	.quad	.LC73
	.quad	.LC74
	.quad	.LC61
	.quad	.LC75
	.quad	.LC76
	.quad	.LC77
	.quad	.LC78
	.quad	.LC79
	.quad	.LC80
	.quad	.LC81
	.quad	.LC61
	.quad	.LC75
	.quad	.LC76
	.quad	.LC82
	.quad	.LC83
	.quad	.LC84
	.quad	.LC67
	.quad	.LC68
	.quad	.LC85
	.quad	.LC86
	.quad	.LC86
	.quad	.LC80
	.quad	.LC87
	.quad	.LC88
	.quad	.LC88
	.quad	.LC89
	.quad	.LC90
	.quad	.LC91
	.quad	.LC79
	.quad	.LC92
	.quad	.LC87
	.quad	.LC84
	.quad	.LC67
	.quad	.LC68
	.quad	.LC61
	.quad	.LC75
	.quad	.LC93
	.quad	.LC92
	.quad	.LC94
	.quad	.LC95
	.quad	.LC67
	.quad	.LC68
	.quad	.LC96
	.quad	.LC97
	.quad	.LC98
	.quad	.LC99
	.quad	.LC100
	.quad	.LC101
	.quad	.LC102
	.quad	.LC103
	.quad	.LC61
	.quad	.LC75
	.quad	.LC95
	.quad	.LC67
	.quad	.LC104
	.quad	.LC95
	.quad	.LC67
	.quad	.LC68
	.quad	.LC61
	.quad	.LC75
	.quad	.LC95
	.quad	.LC105
	.quad	.LC106
	.quad	.LC84
	.quad	.LC67
	.quad	.LC68
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
