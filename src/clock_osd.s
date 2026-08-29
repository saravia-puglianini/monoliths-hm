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
	.string	"[==.]"
.LC2:
	.string	"AC"
.LC3:
	.string	"[=..]"
.LC4:
	.string	"[...]"
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
	.string	"-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1"
	.align 8
.LC21:
	.string	"-misc-dejavu sans mono-bold-r-normal--48-0-0-0-m-0-iso8859-1"
	.section	.rodata.str1.1
.LC22:
	.string	"America/Lima"
.LC23:
	.string	"TZ"
	.section	.rodata.str1.8
	.align 8
.LC24:
	.string	"/sys/class/power_supply/BAT0/capacity"
	.align 8
.LC25:
	.string	"/sys/class/power_supply/ADP1/online"
	.align 8
.LC26:
	.string	"/sys/class/power_supply/BAT0/status"
	.section	.rodata.str1.1
.LC27:
	.string	"Discharging"
.LC28:
	.string	"%s %d%% %02d:%02d:%02d %s"
.LC29:
	.string	"%d de %s del %d"
.LC30:
	.string	"_NET_CLIENT_LIST"
.LC31:
	.string	"ctrl+shift releases"
.LC32:
	.string	"NOT MOUSE"
.LC33:
	.string	""
.LC34:
	.string	"%02d:%02d:%02d"
.LC35:
	.string	"XOSD"
.LC36:
	.string	"_NET_WM_STATE"
.LC37:
	.string	"_NET_WM_STATE_STICKY"
.LC38:
	.string	"_NET_WM_STATE_ABOVE"
.LC39:
	.string	"_NET_WM_DESKTOP"
	.section	.rodata.str1.8
	.align 8
.LC40:
	.string	"clock_osd: Cannot create top XOSD\n"
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
	sub	rsp, 5544
	.cfi_def_cfa_offset 5600
	call	getenv
	mov	edx, OFFSET FLAT:.LC15
	mov	esi, 256
	lea	rdi, [rsp+672]
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
	lea	rdi, [rsp+928]
	call	snprintf
	mov	edx, OFFSET FLAT:.LC17
	xor	eax, eax
	mov	rcx, rbx
	mov	esi, 256
	lea	rdi, [rsp+1184]
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
	je	.L188
	mov	edi, OFFSET FLAT:x11_silent_error_handler
	call	XSetErrorHandler
	movsx	rax, DWORD PTR [rbx+224]
	mov	edi, 6
	sal	rax, 7
	add	rax, QWORD PTR [rbx+232]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rsp], rax
	call	xosd_create
	mov	r14, rax
	mov	QWORD PTR [rsp+24], rax
	test	rax, rax
	je	.L8
	mov	esi, OFFSET FLAT:.LC20
	mov	rdi, rax
	call	xosd_set_font
	xor	esi, esi
	mov	rdi, r14
	call	xosd_set_pos
	mov	esi, 2
	mov	rdi, r14
	call	xosd_set_align
	mov	esi, 50
	mov	rdi, r14
	call	xosd_set_horizontal_offset
	mov	esi, 1
	mov	rdi, r14
	call	xosd_set_shadow_offset
	or	esi, -1
	mov	rdi, r14
	call	xosd_set_timeout
	mov	edi, 4
	call	xosd_create
	mov	QWORD PTR [rsp+8], rax
	test	rax, rax
	je	.L9
.L83:
	mov	r14, QWORD PTR [rsp+8]
	mov	esi, OFFSET FLAT:.LC21
	mov	rdi, r14
	call	xosd_set_font
	xor	esi, esi
	mov	rdi, r14
	call	xosd_set_pos
	mov	esi, 2
	mov	rdi, r14
	call	xosd_set_align
	mov	esi, 30
	mov	rdi, r14
	call	xosd_set_horizontal_offset
	mov	esi, 3
	mov	rdi, r14
	call	xosd_set_shadow_offset
	or	esi, -1
	mov	rdi, r14
	call	xosd_set_timeout
.L9:
	mov	edi, 8
	call	xosd_create
	mov	r14, rax
	mov	QWORD PTR [rsp+16], rax
	test	rax, rax
	je	.L10
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
.L10:
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC22
	mov	edi, OFFSET FLAT:.LC23
	xor	ebp, ebp
	call	setenv
	call	tzset
	xor	edi, edi
	call	time
	mov	DWORD PTR [rsp+36], 0
	pxor	xmm0, xmm0
	mov	QWORD PTR [rsp+40], rax
	or	eax, -1
	mov	DWORD PTR [rsp+52], eax
	mov	DWORD PTR [rsp+48], eax
	lea	rax, [rsp+1444]
	mov	QWORD PTR [rsp+72], rax
	movaps	XMMWORD PTR [rsp+176], xmm0
	movaps	XMMWORD PTR [rsp+192], xmm0
	.p2align 4,,10
	.p2align 3
.L11:
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	je	.L189
.L12:
	mov	rdi, rbx
	lea	rsi, [rsp+1440]
	call	XNextEvent
	mov	rdi, rbx
	call	XPending
	test	eax, eax
	jne	.L12
.L189:
	sub	rsp, 8
	.cfi_def_cfa_offset 5608
	mov	rdi, rbx
	lea	rax, [rsp+112]
	push	rax
	.cfi_def_cfa_offset 5616
	lea	rax, [rsp+116]
	push	rax
	.cfi_def_cfa_offset 5624
	lea	rax, [rsp+120]
	push	rax
	.cfi_def_cfa_offset 5632
	mov	rsi, QWORD PTR [rsp+32]
	lea	r9, [rsp+124]
	lea	r8, [rsp+120]
	lea	rcx, [rsp+152]
	lea	rdx, [rsp+144]
	call	XQueryPointer
	add	rsp, 32
	.cfi_def_cfa_offset 5600
	mov	r13d, eax
	test	eax, eax
	je	.L13
	cmp	DWORD PTR [rsp+48], -1
	mov	eax, DWORD PTR [rsp+88]
	je	.L190
	cmp	DWORD PTR [rsp+48], eax
	jne	.L16
	xor	r13d, r13d
	mov	eax, DWORD PTR [rsp+52]
	cmp	DWORD PTR [rsp+92], eax
	je	.L13
.L16:
	xor	edi, edi
	mov	r13d, 1
	call	time
	mov	QWORD PTR [rsp+40], rax
	mov	eax, DWORD PTR [rsp+88]
	mov	DWORD PTR [rsp+48], eax
	mov	eax, DWORD PTR [rsp+92]
	mov	DWORD PTR [rsp+52], eax
.L13:
	xor	edi, edi
	call	time
	xor	esi, esi
	lea	rdi, [rsp+672]
	mov	r12, rax
	mov	QWORD PTR [rsp+128], rax
	call	access
	test	eax, eax
	je	.L191
	sub	r12d, DWORD PTR [rsp+40]
	cmp	r12d, 99
	jle	.L24
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	lea	rdi, [rsp+1184]
	call	open
	test	eax, eax
	js	.L25
	mov	edi, eax
	call	close
.L25:
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC24
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L28
	mov	edi, eax
	mov	edx, 31
	lea	rsi, [rsp+1440]
	call	read
	mov	edi, ebp
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L28
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1440]
	mov	BYTE PTR [rsp+1440+r14], 0
	call	strtol
	mov	r14d, eax
.L27:
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC25
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L30
	mov	edi, eax
	mov	edx, 31
	lea	rsi, [rsp+1440]
	call	read
	mov	edi, ebp
	mov	r15, rax
	call	close
	test	r15, r15
	jle	.L30
	xor	esi, esi
	mov	edx, 10
	lea	rdi, [rsp+1440]
	mov	BYTE PTR [rsp+1440+r15], 0
	call	strtol
	cmp	eax, 1
	jne	.L30
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC26
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L184
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1440]
	call	read
	mov	edi, ebp
	mov	r15, rax
	call	close
	test	r15, r15
	jle	.L184
	mov	esi, OFFSET FLAT:.LC27
	lea	rdi, [rsp+1440]
	mov	BYTE PTR [rsp+1440+r15], 0
	call	strstr
	test	rax, rax
	je	.L184
	.p2align 4,,10
	.p2align 3
.L30:
	mov	r15d, OFFSET FLAT:.LC5
	cmp	r14d, 84
	jg	.L34
	mov	r15d, OFFSET FLAT:.LC1
	cmp	r14d, 39
	jg	.L34
	cmp	r14d, 14
	mov	r15d, OFFSET FLAT:.LC3
	mov	eax, OFFSET FLAT:.LC4
	cmovle	r15, rax
	.p2align 4,,10
	.p2align 3
.L34:
	lea	rsi, [rsp+208]
	lea	rdi, [rsp+128]
	call	localtime_r
	mov	ecx, DWORD PTR [rsp+216]
	mov	edx, 715827883
	mov	r8d, r14d
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
	mov	rcx, r15
	cmovle	rax, rdx
	sub	rsp, 8
	.cfi_def_cfa_offset 5608
	mov	edx, OFFSET FLAT:.LC28
	mov	r9d, ebp
	push	rax
	.cfi_def_cfa_offset 5616
	mov	eax, DWORD PTR [rsp+224]
	push	rax
	.cfi_def_cfa_offset 5624
	mov	eax, DWORD PTR [rsp+236]
	push	rax
	.cfi_def_cfa_offset 5632
	xor	eax, eax
	lea	rdi, [rsp+304]
	call	snprintf
	add	rsp, 32
	.cfi_def_cfa_offset 5600
	movsx	rax, DWORD PTR [rsp+224]
	mov	edx, DWORD PTR [rsp+228]
	mov	ecx, DWORD PTR [rsp+220]
	mov	esi, 128
	lea	rdi, [rsp+400]
	mov	r8, QWORD PTR months_es[0+rax*8]
	lea	r9d, [rdx+1900]
	xor	eax, eax
	mov	edx, OFFSET FLAT:.LC29
	call	snprintf
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC30
	mov	rdi, rbx
	call	XInternAtom
	test	rax, rax
	je	.L45
	xor	r9d, r9d
	mov	r8d, 1024
	mov	rdx, rax
	mov	rdi, rbx
	lea	rcx, [rsp+528]
	mov	QWORD PTR [rsp+528], 0
	push	rcx
	.cfi_def_cfa_offset 5608
	lea	rcx, [rsp+176]
	push	rcx
	.cfi_def_cfa_offset 5616
	lea	rcx, [rsp+176]
	push	rcx
	.cfi_def_cfa_offset 5624
	lea	rcx, [rsp+168]
	push	rcx
	.cfi_def_cfa_offset 5632
	lea	rcx, [rsp+184]
	push	rcx
	.cfi_def_cfa_offset 5640
	xor	ecx, ecx
	push	33
	.cfi_def_cfa_offset 5648
	mov	rsi, QWORD PTR [rsp+48]
	call	XGetWindowProperty
	add	rsp, 48
	.cfi_def_cfa_offset 5600
	test	eax, eax
	jne	.L45
	mov	r14, QWORD PTR [rsp+528]
	test	r14, r14
	je	.L45
	cmp	QWORD PTR [rsp+160], 0
	je	.L39
	mov	DWORD PTR [rsp+56], ebp
	xor	r15d, r15d
	.p2align 4,,10
	.p2align 3
.L44:
	mov	rsi, QWORD PTR [r14+r15*8]
	mov	rdi, rbx
	lea	rdx, [rsp+1440]
	mov	QWORD PTR [rsp+1440], 0
	call	XFetchName
	test	eax, eax
	jle	.L40
	mov	rbp, QWORD PTR [rsp+1440]
	test	rbp, rbp
	je	.L40
	mov	esi, OFFSET FLAT:.LC31
	mov	rdi, rbp
	call	strstr
	test	rax, rax
	jne	.L192
	mov	rdi, rbp
	call	XFree
.L40:
	add	r15, 1
	cmp	r15, QWORD PTR [rsp+160]
	jb	.L44
	mov	ebp, DWORD PTR [rsp+56]
	mov	r14, QWORD PTR [rsp+528]
.L39:
	mov	rdi, r14
	call	XFree
	.p2align 4,,10
	.p2align 3
.L45:
	xor	esi, esi
	lea	rdi, [rsp+928]
	xor	eax, eax
	call	open
	mov	r14d, eax
	test	eax, eax
	js	.L78
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1440]
	call	read
	mov	edi, r14d
	mov	r15, rax
	call	close
	test	r15, r15
	jle	.L78
	mov	esi, OFFSET FLAT:.LC32
	lea	rdi, [rsp+1440]
	mov	BYTE PTR [rsp+1440+r15], 0
	mov	r14d, OFFSET FLAT:.LC13
	call	strstr
	mov	r15d, OFFSET FLAT:.LC12
	mov	edx, OFFSET FLAT:.LC8
	test	rax, rax
	mov	eax, OFFSET FLAT:.LC9
	cmove	r15, rdx
	cmove	r14, rax
.L46:
	lea	rdi, [rsp+176]
	mov	rsi, r14
	call	strcmp
	test	eax, eax
	je	.L47
	mov	rax, QWORD PTR [rsp+24]
	test	rax, rax
	je	.L48
	mov	rsi, r14
	mov	rdi, rax
	call	xosd_set_colour
.L48:
	mov	rax, QWORD PTR [rsp+8]
	test	rax, rax
	je	.L49
	mov	rsi, r14
	mov	rdi, rax
	call	xosd_set_colour
.L49:
	mov	rax, QWORD PTR [rsp+16]
	test	rax, rax
	je	.L50
	mov	rsi, r14
	mov	rdi, rax
	call	xosd_set_colour
.L50:
	mov	edx, 31
	mov	rsi, r14
	lea	rdi, [rsp+176]
	call	strncpy
.L47:
	cmp	QWORD PTR [rsp+8], 0
	je	.L51
	and	r13d, 1
	je	.L51
	mov	rax, QWORD PTR [rsp+24]
	test	rax, rax
	je	.L52
	mov	rdi, rax
	call	xosd_hide
.L52:
	movsx	rax, DWORD PTR [rsp+232]
	mov	r14, QWORD PTR [rsp+8]
	mov	edx, 1
	xor	esi, esi
	mov	rcx, QWORD PTR weekdays_es[0+rax*8]
	mov	rdi, r14
	xor	eax, eax
	call	xosd_display
	mov	edx, 1
	mov	rdi, r14
	xor	eax, eax
	lea	rcx, [rsp+400]
	mov	esi, 1
	call	xosd_display
	mov	edx, 1
	mov	rdi, r14
	xor	eax, eax
	lea	rcx, [rsp+272]
	mov	esi, 2
	call	xosd_display
	mov	rcx, r15
	mov	edx, 1
	mov	esi, 3
.L186:
	mov	rdi, r14
	xor	eax, eax
	call	xosd_display
	mov	rdi, r14
	call	xosd_show
.L53:
	cmp	QWORD PTR [rsp+16], 0
	setne	al
	cmp	r12d, 99
	jle	.L55
	test	al, al
	jne	.L193
.L55:
	mov	edi, DWORD PTR [rsp+36]
	test	edi, edi
	je	.L66
	test	al, al
	je	.L66
	mov	rdi, QWORD PTR [rsp+16]
	call	xosd_hide
	mov	DWORD PTR [rsp+36], 0
.L66:
	mov	rsi, QWORD PTR [rsp]
	lea	r9, [rsp+108]
	lea	r8, [rsp+152]
	mov	rdi, rbx
	lea	rcx, [rsp+144]
	lea	rdx, [rsp+136]
	call	XQueryTree
	test	eax, eax
	je	.L68
	mov	esi, DWORD PTR [rsp+108]
	mov	rdi, QWORD PTR [rsp+152]
	test	esi, esi
	je	.L69
	xor	ebp, ebp
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L70:
	mov	rax, QWORD PTR [rsp+160]
	test	rax, rax
	je	.L187
	mov	edi, OFFSET FLAT:.LC35
	mov	ecx, 5
	mov	rsi, rax
	repz cmpsb
	mov	rdi, rax
	seta	dl
	sbb	dl, 0
	test	dl, dl
	jne	.L73
	call	XFree
	mov	rax, QWORD PTR [rsp+152]
	mov	rdi, rbx
	lea	rdx, [rsp+528]
	mov	rsi, QWORD PTR [rax+r12*8]
	call	XGetWindowAttributes
	mov	rdi, QWORD PTR [rsp+152]
	test	eax, eax
	je	.L71
	mov	ecx, DWORD PTR [rsp+620]
	test	ecx, ecx
	jne	.L194
.L71:
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+108]
	jnb	.L69
	.p2align 4,,10
	.p2align 3
.L76:
	mov	r12d, ebp
	lea	rdx, [rsp+160]
	mov	QWORD PTR [rsp+160], 0
	mov	rsi, QWORD PTR [rdi+r12*8]
	mov	rdi, rbx
	call	XFetchName
	test	eax, eax
	jg	.L70
.L187:
	mov	rdi, QWORD PTR [rsp+152]
.L195:
	add	ebp, 1
	cmp	ebp, DWORD PTR [rsp+108]
	jb	.L76
.L69:
	test	rdi, rdi
	je	.L68
	call	XFree
.L68:
	mov	edi, 60000
	mov	ebp, 1
	call	usleep
	jmp	.L11
.L8:
	mov	edi, 4
	call	xosd_create
	mov	QWORD PTR [rsp+8], rax
	test	rax, rax
	jne	.L83
	mov	edi, OFFSET FLAT:.LC40
	mov	edx, 34
	mov	esi, 1
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	mov	rdi, rbx
	call	XCloseDisplay
.L175:
	add	rsp, 5544
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
	.p2align 4,,10
	.p2align 3
.L73:
	.cfi_restore_state
	call	XFree
	mov	rdi, QWORD PTR [rsp+152]
	jmp	.L195
	.p2align 4,,10
	.p2align 3
.L28:
	xor	r14d, r14d
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L51:
	cmp	QWORD PTR [rsp+24], 0
	je	.L53
	mov	rax, QWORD PTR [rsp+8]
	test	rax, rax
	je	.L54
	mov	rdi, rax
	call	xosd_hide
.L54:
	movsx	rax, DWORD PTR [rsp+232]
	mov	r14, QWORD PTR [rsp+24]
	mov	edx, 1
	xor	esi, esi
	mov	rcx, QWORD PTR weekdays_es[0+rax*8]
	mov	rdi, r14
	xor	eax, eax
	call	xosd_display
	mov	ecx, OFFSET FLAT:.LC33
	mov	rdi, r14
	xor	eax, eax
	mov	edx, 1
	mov	esi, 1
	call	xosd_display
	mov	edx, 1
	mov	rdi, r14
	xor	eax, eax
	lea	rcx, [rsp+400]
	mov	esi, 2
	call	xosd_display
	mov	ecx, OFFSET FLAT:.LC33
	mov	rdi, r14
	xor	eax, eax
	mov	edx, 1
	mov	esi, 3
	call	xosd_display
	mov	edx, 1
	mov	rdi, r14
	xor	eax, eax
	lea	rcx, [rsp+272]
	mov	esi, 4
	call	xosd_display
	mov	rcx, r15
	mov	edx, 1
	mov	esi, 5
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L24:
	lea	rdi, [rsp+1184]
	call	unlink
	jmp	.L25
	.p2align 4,,10
	.p2align 3
.L191:
	test	ebp, ebp
	je	.L19
	mov	rax, QWORD PTR [rsp+24]
	test	rax, rax
	je	.L20
	mov	rdi, rax
	call	xosd_hide
.L20:
	mov	rax, QWORD PTR [rsp+8]
	test	rax, rax
	je	.L19
	mov	rdi, rax
	call	xosd_hide
.L19:
	mov	r11d, DWORD PTR [rsp+36]
	test	r11d, r11d
	je	.L22
	mov	rax, QWORD PTR [rsp+16]
	test	rax, rax
	je	.L22
	mov	rdi, rax
	call	xosd_hide
	mov	DWORD PTR [rsp+36], 0
.L22:
	mov	edi, 60000
	xor	ebp, ebp
	call	usleep
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L78:
	mov	r15d, OFFSET FLAT:.LC8
	mov	r14d, OFFSET FLAT:.LC9
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L190:
	mov	ecx, DWORD PTR [rsp+92]
	mov	DWORD PTR [rsp+48], eax
	xor	r13d, r13d
	mov	DWORD PTR [rsp+52], ecx
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L193:
	mov	ecx, ebp
	mov	edx, OFFSET FLAT:.LC34
	mov	esi, 16
	xor	eax, eax
	mov	r9d, DWORD PTR [rsp+208]
	mov	r8d, DWORD PTR [rsp+212]
	lea	rdi, [rsp+528]
	lea	r13, [rsp+529]
	lea	r14, [rsp+3488]
	call	snprintf
	mov	BYTE PTR [rsp+1440], 0
	movsx	r12, BYTE PTR [rsp+528]
	mov	BYTE PTR [rsp+1696], 0
	mov	BYTE PTR [rsp+1952], 0
	mov	BYTE PTR [rsp+2208], 0
	mov	BYTE PTR [rsp+2464], 0
	mov	BYTE PTR [rsp+2720], 0
	mov	BYTE PTR [rsp+2976], 0
	mov	BYTE PTR [rsp+3232], 0
	test	r12b, r12b
	je	.L65
	.p2align 4,,10
	.p2align 3
.L64:
	lea	eax, [r12-48]
	cmp	al, 9
	jbe	.L58
	xor	r15d, r15d
	.p2align 4,,10
	.p2align 3
.L62:
	mov	rbp, r15
	lea	rax, [rsp+1440]
	sal	rbp, 8
	add	rbp, rax
	mov	rdi, rbp
	cmp	r12b, 58
	je	.L196
	call	strlen
	add	r15, 1
	mov	r9d, 32
	mov	WORD PTR [rbp+0+rax], r9w
	cmp	r15, 8
	jne	.L62
	add	r13, 1
	movsx	r12, BYTE PTR [r13-1]
	test	r12b, r12b
	jne	.L64
.L65:
	mov	r12, QWORD PTR [rsp+16]
	xor	ebp, ebp
	.p2align 4,,10
	.p2align 3
.L57:
	mov	rcx, rbp
	lea	rax, [rsp+1440]
	mov	esi, ebp
	mov	rdi, r12
	sal	rcx, 8
	mov	edx, 1
	add	rbp, 1
	add	rcx, rax
	xor	eax, eax
	call	xosd_display
	cmp	rbp, 8
	jne	.L57
	mov	rdi, QWORD PTR [rsp+16]
	call	xosd_show
	mov	DWORD PTR [rsp+36], 1
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L196:
	call	strlen
	mov	rsi, QWORD PTR ascii_colon[0+r15*8]
	add	r15, 1
	lea	rdi, [rbp+0+rax]
	call	stpcpy
	mov	r10d, 32
	mov	WORD PTR [rax], r10w
	cmp	r15, 8
	jne	.L62
	add	r13, 1
	movsx	r12, BYTE PTR [r13-1]
	test	r12b, r12b
	jne	.L64
	jmp	.L65
	.p2align 4,,10
	.p2align 3
.L58:
	sal	r12, 6
	lea	rbp, [rsp+1440]
	add	r12, OFFSET FLAT:ascii_v-3072
	.p2align 4,,10
	.p2align 3
.L63:
	mov	rdi, rbp
	add	r12, 8
	call	strlen
	mov	rsi, QWORD PTR [r12-8]
	lea	rdi, [rbp+0+rax]
	add	rbp, 256
	call	stpcpy
	mov	r8d, 32
	mov	WORD PTR [rax], r8w
	cmp	r14, rbp
	jne	.L63
	add	r13, 1
	movsx	r12, BYTE PTR [r13-1]
	test	r12b, r12b
	jne	.L64
	jmp	.L65
	.p2align 4,,10
	.p2align 3
.L184:
	mov	r15d, OFFSET FLAT:.LC2
	jmp	.L34
.L194:
	mov	r13, QWORD PTR [rdi+r12*8]
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC36
	mov	rdi, rbx
	call	XInternAtom
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC37
	mov	rdi, rbx
	mov	QWORD PTR [rsp+56], rax
	call	XInternAtom
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC38
	mov	rdi, rbx
	mov	r14, rax
	call	XInternAtom
	lea	rdi, [rsp+1448]
	lea	r8, [rsp+1440]
	mov	rdx, rax
	mov	rax, QWORD PTR [rsp+72]
	mov	QWORD PTR [rax], 0
	sub	rax, rdi
	mov	QWORD PTR [rsp+1624], 0
	mov	rcx, rax
	xor	eax, eax
	add	ecx, 188
	shr	ecx, 3
	rep stosq
	mov	QWORD PTR [rsp+64], r13
	mov	ecx, 1572864
	mov	rdi, rbx
	mov	QWORD PTR [rsp+1512], rdx
	xor	edx, edx
	movq	xmm0, QWORD PTR [rsp+64]
	mov	rsi, QWORD PTR [rsp]
	mov	DWORD PTR [rsp+1440], 33
	mov	DWORD PTR [rsp+1488], 32
	mov	QWORD PTR [rsp+1496], 1
	mov	QWORD PTR [rsp+1504], r14
	movhps	xmm0, QWORD PTR [rsp+56]
	mov	QWORD PTR [rsp+1520], 1
	movaps	XMMWORD PTR [rsp+1472], xmm0
	call	XSendEvent
	xor	edx, edx
	mov	esi, OFFSET FLAT:.LC39
	mov	rdi, rbx
	call	XInternAtom
	mov	ecx, 4294967295
	xor	r9d, r9d
	mov	rsi, r13
	mov	QWORD PTR [rsp+168], rcx
	mov	rdx, rax
	mov	r8d, 32
	mov	rdi, rbx
	push	1
	.cfi_def_cfa_offset 5608
	lea	rcx, [rsp+176]
	push	rcx
	.cfi_def_cfa_offset 5616
	mov	ecx, 6
	call	XChangeProperty
	mov	rax, QWORD PTR [rsp+168]
	mov	rdi, rbx
	mov	rsi, QWORD PTR [rax+r12*8]
	call	XRaiseWindow
	mov	rdi, QWORD PTR [rsp+168]
	pop	rax
	.cfi_def_cfa_offset 5608
	pop	rdx
	.cfi_def_cfa_offset 5600
	jmp	.L71
.L192:
	mov	rdx, rbp
	mov	ebp, DWORD PTR [rsp+56]
	mov	rdi, rdx
	call	XFree
	mov	rdi, QWORD PTR [rsp+528]
	call	XFree
	xor	esi, esi
	lea	rdi, [rsp+928]
	xor	eax, eax
	call	open
	mov	r14d, eax
	test	eax, eax
	jns	.L197
.L185:
	mov	r15d, OFFSET FLAT:.LC10
	mov	r14d, OFFSET FLAT:.LC11
	jmp	.L46
.L188:
	mov	edx, 33
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC19
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	jmp	.L175
.L197:
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1440]
	call	read
	mov	edi, r14d
	mov	r15, rax
	call	close
	test	r15, r15
	jle	.L185
	mov	BYTE PTR [rsp+1440+r15], 0
	jmp	.L185
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.str1.1
.LC41:
	.string	"ENERO"
.LC42:
	.string	"FEBRERO"
.LC43:
	.string	"MARZO"
.LC44:
	.string	"ABRIL"
.LC45:
	.string	"MAYO"
.LC46:
	.string	"JUNIO"
.LC47:
	.string	"JULIO"
.LC48:
	.string	"AGOSTO"
.LC49:
	.string	"SEPTIEMBRE"
.LC50:
	.string	"OCTUBRE"
.LC51:
	.string	"NOVIEMBRE"
.LC52:
	.string	"DICIEMBRE"
	.section	.rodata
	.align 32
	.type	months_es, @object
	.size	months_es, 96
months_es:
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
	.quad	.LC51
	.quad	.LC52
	.section	.rodata.str1.1
.LC53:
	.string	"DOMINGO"
.LC54:
	.string	"LUNES"
.LC55:
	.string	"MARTES"
.LC56:
	.string	"MIERCOLES"
.LC57:
	.string	"JUEVES"
.LC58:
	.string	"VIERNES"
.LC59:
	.string	"SABADO"
	.section	.rodata
	.align 32
	.type	weekdays_es, @object
	.size	weekdays_es, 56
weekdays_es:
	.quad	.LC53
	.quad	.LC54
	.quad	.LC55
	.quad	.LC56
	.quad	.LC57
	.quad	.LC58
	.quad	.LC59
	.section	.rodata.str1.1
.LC60:
	.string	"    "
.LC61:
	.string	" /$$"
.LC62:
	.string	"|__/"
	.section	.rodata
	.align 32
	.type	ascii_colon, @object
	.size	ascii_colon, 64
ascii_colon:
	.quad	.LC60
	.quad	.LC61
	.quad	.LC62
	.quad	.LC60
	.quad	.LC61
	.quad	.LC62
	.quad	.LC60
	.quad	.LC60
	.section	.rodata.str1.1
.LC63:
	.string	"  /$$$$$$ "
.LC64:
	.string	" /$$$_  $$"
.LC65:
	.string	"| $$$$\\ $$"
.LC66:
	.string	"| $$ $$ $$"
.LC67:
	.string	"| $$\\ $$$$"
.LC68:
	.string	"| $$ \\ $$$"
.LC69:
	.string	"|  $$$$$$/"
.LC70:
	.string	" \\______/ "
.LC71:
	.string	"   /$$  "
.LC72:
	.string	" /$$$$  "
.LC73:
	.string	"|_  $$  "
.LC74:
	.string	"  | $$  "
.LC75:
	.string	" /$$$$$$"
.LC76:
	.string	"|______/"
.LC77:
	.string	" /$$__  $$"
.LC78:
	.string	"|__/  \\ $$"
.LC79:
	.string	"  /$$$$$$/"
.LC80:
	.string	" /$$____/ "
.LC81:
	.string	"| $$      "
.LC82:
	.string	"| $$$$$$$$"
.LC83:
	.string	"|________/"
.LC84:
	.string	"   /$$$$$/"
.LC85:
	.string	"  |___  $$"
.LC86:
	.string	" /$$  \\ $$"
.LC87:
	.string	" /$$   /$$"
.LC88:
	.string	"| $$  | $$"
.LC89:
	.string	"|_____  $$"
.LC90:
	.string	"      | $$"
.LC91:
	.string	"      |__/"
.LC92:
	.string	" /$$$$$$$ "
.LC93:
	.string	"| $$____/ "
.LC94:
	.string	"| $$$$$$$ "
.LC95:
	.string	"| $$  \\__/"
.LC96:
	.string	"| $$__  $$"
.LC97:
	.string	"| $$  \\ $$"
.LC98:
	.string	" /$$$$$$$$"
.LC99:
	.string	"|_____ $$/"
.LC100:
	.string	"     /$$/ "
.LC101:
	.string	"    /$$/  "
.LC102:
	.string	"   /$$/   "
.LC103:
	.string	"  /$$/    "
.LC104:
	.string	" /$$/     "
.LC105:
	.string	"|__/      "
.LC106:
	.string	" >$$__  $$"
.LC107:
	.string	"|  $$$$$$$"
.LC108:
	.string	" \\____  $$"
	.section	.rodata
	.align 32
	.type	ascii_v, @object
	.size	ascii_v, 640
ascii_v:
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
	.quad	.LC73
	.quad	.LC74
	.quad	.LC74
	.quad	.LC74
	.quad	.LC75
	.quad	.LC76
	.quad	.LC63
	.quad	.LC77
	.quad	.LC78
	.quad	.LC79
	.quad	.LC80
	.quad	.LC81
	.quad	.LC82
	.quad	.LC83
	.quad	.LC63
	.quad	.LC77
	.quad	.LC78
	.quad	.LC84
	.quad	.LC85
	.quad	.LC86
	.quad	.LC69
	.quad	.LC70
	.quad	.LC87
	.quad	.LC88
	.quad	.LC88
	.quad	.LC82
	.quad	.LC89
	.quad	.LC90
	.quad	.LC90
	.quad	.LC91
	.quad	.LC92
	.quad	.LC93
	.quad	.LC81
	.quad	.LC94
	.quad	.LC89
	.quad	.LC86
	.quad	.LC69
	.quad	.LC70
	.quad	.LC63
	.quad	.LC77
	.quad	.LC95
	.quad	.LC94
	.quad	.LC96
	.quad	.LC97
	.quad	.LC69
	.quad	.LC70
	.quad	.LC98
	.quad	.LC99
	.quad	.LC100
	.quad	.LC101
	.quad	.LC102
	.quad	.LC103
	.quad	.LC104
	.quad	.LC105
	.quad	.LC63
	.quad	.LC77
	.quad	.LC97
	.quad	.LC69
	.quad	.LC106
	.quad	.LC97
	.quad	.LC69
	.quad	.LC70
	.quad	.LC63
	.quad	.LC77
	.quad	.LC97
	.quad	.LC107
	.quad	.LC108
	.quad	.LC86
	.quad	.LC69
	.quad	.LC70
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
