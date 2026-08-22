	.file	"clock_osd.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"/home/user"
.LC1:
	.string	"[\342\226\210\342\226\210\342\226\221]"
.LC2:
	.string	"[\342\226\210\342\226\221\342\226\221]"
.LC3:
	.string	"\342\232\241"
.LC4:
	.string	"[\342\226\210\342\226\210\342\226\210]"
.LC5:
	.string	"[\342\226\221\342\226\221\342\226\221]"
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
	.string	"%s %d%% %02d:%02d %s"
.LC26:
	.string	"_NET_CLIENT_LIST"
.LC27:
	.string	"ctrl+shift releases"
.LC28:
	.string	"NOT MOUSE"
.LC29:
	.string	"%02d:%02d:%02d"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB36:
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
	sub	rsp, 5256
	.cfi_def_cfa_offset 5312
	call	getenv
	mov	edx, OFFSET FLAT:.LC15
	mov	esi, 256
	lea	rdi, [rsp+384]
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
	lea	rdi, [rsp+640]
	call	snprintf
	mov	edx, OFFSET FLAT:.LC17
	xor	eax, eax
	mov	rcx, rbx
	mov	esi, 256
	lea	rdi, [rsp+896]
	call	snprintf
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	mov	edi, OFFSET FLAT:.LC18
	call	open
	test	eax, eax
	js	.L3
	mov	edi, eax
	call	close
.L3:
	xor	edi, edi
	call	XOpenDisplay
	mov	QWORD PTR [rsp+8], rax
	test	rax, rax
	je	.L122
	mov	rcx, rax
	movsx	rax, DWORD PTR [rax+224]
	mov	edi, 4
	sal	rax, 7
	add	rax, QWORD PTR [rcx+232]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rsp+16], rax
	call	xosd_create
	mov	QWORD PTR [rsp], rax
	test	rax, rax
	je	.L123
	mov	rbx, QWORD PTR [rsp]
	xor	esi, esi
	mov	rdi, rbx
	call	xosd_set_pos
	mov	rdi, rbx
	mov	esi, 2
	call	xosd_set_align
	mov	rdi, rbx
	mov	esi, 50
	call	xosd_set_horizontal_offset
	mov	rdi, rbx
	mov	esi, 1
	call	xosd_set_shadow_offset
	mov	rdi, rbx
	or	esi, -1
	call	xosd_set_timeout
	mov	edi, 8
	call	xosd_create
	mov	rbx, rax
	mov	QWORD PTR [rsp+24], rax
	test	rax, rax
	je	.L7
	mov	esi, 1
	mov	rdi, rax
	call	xosd_set_pos
	mov	esi, 2
	mov	rdi, rbx
	call	xosd_set_align
	mov	esi, 1
	mov	rdi, rbx
	call	xosd_set_shadow_offset
	or	esi, -1
	mov	rdi, rbx
	call	xosd_set_timeout
.L7:
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC21
	mov	edi, OFFSET FLAT:.LC22
	call	setenv
	call	tzset
	xor	edi, edi
	call	time
	cmp	QWORD PTR [rsp+24], 0
	pxor	xmm0, xmm0
	setne	BYTE PTR [rsp+42]
	xor	r15d, r15d
	xor	r12d, r12d
	mov	QWORD PTR [rsp+32], rax
	or	eax, -1
	mov	DWORD PTR [rsp+48], eax
	mov	DWORD PTR [rsp+44], eax
	lea	rax, [rsp+3200]
	mov	QWORD PTR [rsp+56], rax
	movaps	XMMWORD PTR [rsp+160], xmm0
	movaps	XMMWORD PTR [rsp+176], xmm0
	.p2align 4,,10
	.p2align 3
.L8:
	xor	esi, esi
	lea	rdi, [rsp+384]
	call	access
	test	eax, eax
	jne	.L9
	test	r12d, r12d
	jne	.L124
.L10:
	test	r15d, r15d
	je	.L11
	cmp	BYTE PTR [rsp+42], 0
	je	.L11
	mov	rdi, QWORD PTR [rsp+24]
	xor	r15d, r15d
	call	xosd_hide
.L11:
	mov	edi, 200000
	xor	r12d, r12d
	call	usleep
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L9:
	sub	rsp, 8
	.cfi_def_cfa_offset 5320
	lea	rax, [rsp+96]
	push	rax
	.cfi_def_cfa_offset 5328
	lea	rax, [rsp+100]
	push	rax
	.cfi_def_cfa_offset 5336
	lea	rax, [rsp+104]
	push	rax
	.cfi_def_cfa_offset 5344
	mov	rsi, QWORD PTR [rsp+48]
	mov	rdi, QWORD PTR [rsp+40]
	lea	r9, [rsp+108]
	lea	r8, [rsp+104]
	lea	rcx, [rsp+136]
	lea	rdx, [rsp+128]
	call	XQueryPointer
	add	rsp, 32
	.cfi_def_cfa_offset 5312
	test	eax, eax
	je	.L13
	mov	ebx, DWORD PTR [rsp+72]
	mov	ebp, DWORD PTR [rsp+76]
	cmp	ebx, DWORD PTR [rsp+44]
	jne	.L14
	cmp	DWORD PTR [rsp+48], ebp
	je	.L13
.L14:
	xor	edi, edi
	call	time
	mov	DWORD PTR [rsp+48], ebp
	mov	QWORD PTR [rsp+32], rax
	mov	DWORD PTR [rsp+44], ebx
.L13:
	xor	edi, edi
	call	time
	mov	ebp, eax
	sub	ebp, DWORD PTR [rsp+32]
	mov	QWORD PTR [rsp+112], rax
	cmp	ebp, 99
	setg	BYTE PTR [rsp+43]
	jle	.L15
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	lea	rdi, [rsp+896]
	call	open
	test	eax, eax
	js	.L16
	mov	edi, eax
	call	close
.L16:
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC23
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L19
	mov	edi, eax
	mov	edx, 31
	lea	rsi, [rsp+1152]
	call	read
	mov	edi, ebx
	mov	r13, rax
	call	close
	test	r13, r13
	jle	.L19
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1152]
	mov	BYTE PTR [rsp+1152+r13], 0
	call	strtol
	mov	r13d, eax
.L18:
	xor	esi, esi
	mov	edi, OFFSET FLAT:.LC24
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L21
	mov	edi, eax
	mov	edx, 31
	lea	rsi, [rsp+1152]
	call	read
	mov	edi, ebx
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L21
	mov	edx, 10
	xor	esi, esi
	lea	rdi, [rsp+1152]
	mov	BYTE PTR [rsp+1152+r14], 0
	call	strtol
	mov	r14d, OFFSET FLAT:.LC3
	cmp	eax, 1
	jne	.L21
.L23:
	lea	rsi, [rsp+192]
	lea	rdi, [rsp+112]
	call	localtime_r
	mov	ecx, DWORD PTR [rsp+200]
	mov	eax, 715827883
	imul	ecx
	mov	eax, ecx
	mov	ebx, ecx
	sar	eax, 31
	sar	edx
	sub	edx, eax
	lea	eax, [rdx+rdx*2]
	mov	edx, OFFSET FLAT:.LC7
	sal	eax, 2
	sub	ebx, eax
	mov	eax, 12
	cmove	ebx, eax
	cmp	ecx, 11
	mov	eax, OFFSET FLAT:.LC6
	cmovle	rax, rdx
	cmp	ebp, 99
	jle	.L125
	mov	BYTE PTR [rsp+256], 0
.L27:
	mov	r14, QWORD PTR [rsp+8]
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC26
	mov	rdi, r14
	call	XInternAtom
	test	rax, rax
	je	.L35
	xor	r9d, r9d
	mov	r8d, 1024
	mov	rdx, rax
	mov	rdi, r14
	lea	rcx, [rsp+144]
	mov	QWORD PTR [rsp+144], 0
	push	rcx
	.cfi_def_cfa_offset 5320
	lea	rcx, [rsp+144]
	push	rcx
	.cfi_def_cfa_offset 5328
	lea	rcx, [rsp+144]
	push	rcx
	.cfi_def_cfa_offset 5336
	lea	rcx, [rsp+116]
	push	rcx
	.cfi_def_cfa_offset 5344
	lea	rcx, [rsp+152]
	push	rcx
	.cfi_def_cfa_offset 5352
	xor	ecx, ecx
	push	33
	.cfi_def_cfa_offset 5360
	mov	rsi, QWORD PTR [rsp+64]
	call	XGetWindowProperty
	add	rsp, 48
	.cfi_def_cfa_offset 5312
	test	eax, eax
	jne	.L35
	mov	rbp, QWORD PTR [rsp+144]
	test	rbp, rbp
	je	.L35
	cmp	QWORD PTR [rsp+128], 0
	je	.L29
	mov	DWORD PTR [rsp+52], ebx
	xor	r13d, r13d
	.p2align 4,,10
	.p2align 3
.L34:
	mov	rsi, QWORD PTR [rbp+0+r13*8]
	mov	rdi, r14
	lea	rdx, [rsp+1152]
	mov	QWORD PTR [rsp+1152], 0
	call	XFetchName
	test	eax, eax
	jle	.L30
	mov	rbx, QWORD PTR [rsp+1152]
	test	rbx, rbx
	je	.L30
	mov	esi, OFFSET FLAT:.LC27
	mov	rdi, rbx
	call	strstr
	test	rax, rax
	jne	.L126
	mov	rdi, rbx
	call	XFree
.L30:
	add	r13, 1
	cmp	r13, QWORD PTR [rsp+128]
	jb	.L34
	mov	ebx, DWORD PTR [rsp+52]
	mov	rbp, QWORD PTR [rsp+144]
.L29:
	mov	rdi, rbp
	call	XFree
	.p2align 4,,10
	.p2align 3
.L35:
	xor	esi, esi
	lea	rdi, [rsp+640]
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L53
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1152]
	call	read
	mov	edi, ebp
	mov	r13, rax
	call	close
	test	r13, r13
	jle	.L53
	mov	esi, OFFSET FLAT:.LC28
	lea	rdi, [rsp+1152]
	mov	ebp, OFFSET FLAT:.LC13
	mov	BYTE PTR [rsp+1152+r13], 0
	call	strstr
	mov	r13d, OFFSET FLAT:.LC12
	mov	edx, OFFSET FLAT:.LC8
	test	rax, rax
	mov	eax, OFFSET FLAT:.LC9
	cmove	r13, rdx
	cmove	rbp, rax
.L36:
	lea	rdi, [rsp+160]
	mov	rsi, rbp
	call	strcmp
	test	eax, eax
	jne	.L127
.L37:
	mov	r14, QWORD PTR [rsp]
	mov	edx, 1
	mov	esi, 2
	xor	eax, eax
	lea	rcx, [rsp+256]
	mov	rdi, r14
	call	xosd_display
	xor	eax, eax
	mov	rcx, r13
	mov	edx, 1
	mov	esi, 3
	mov	rdi, r14
	call	xosd_display
	test	r12d, r12d
	je	.L128
.L39:
	cmp	BYTE PTR [rsp+43], 0
	je	.L40
	cmp	BYTE PTR [rsp+42], 0
	jne	.L129
.L40:
	test	r15d, r15d
	je	.L52
	cmp	BYTE PTR [rsp+42], 0
	je	.L52
	mov	rdi, QWORD PTR [rsp+24]
	xor	r15d, r15d
	call	xosd_hide
.L52:
	mov	edi, 100000
	mov	r12d, 1
	call	usleep
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L124:
	mov	rdi, QWORD PTR [rsp]
	call	xosd_hide
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L19:
	xor	r13d, r13d
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L21:
	mov	r14d, OFFSET FLAT:.LC4
	cmp	r13d, 84
	jg	.L23
	mov	r14d, OFFSET FLAT:.LC1
	cmp	r13d, 39
	jg	.L23
	cmp	r13d, 14
	mov	r14d, OFFSET FLAT:.LC2
	mov	eax, OFFSET FLAT:.LC5
	cmovle	r14, rax
	jmp	.L23
	.p2align 4,,10
	.p2align 3
.L15:
	lea	rdi, [rsp+896]
	call	unlink
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L125:
	push	rax
	.cfi_def_cfa_offset 5320
	mov	eax, DWORD PTR [rsp+204]
	mov	r8d, r13d
	mov	r9d, ebx
	mov	rcx, r14
	mov	edx, OFFSET FLAT:.LC25
	mov	esi, 128
	push	rax
	.cfi_def_cfa_offset 5328
	xor	eax, eax
	lea	rdi, [rsp+272]
	call	snprintf
	pop	rdi
	.cfi_def_cfa_offset 5320
	pop	r8
	.cfi_def_cfa_offset 5312
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L128:
	mov	rdi, QWORD PTR [rsp]
	call	xosd_show
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L127:
	mov	rdi, QWORD PTR [rsp]
	mov	rsi, rbp
	call	xosd_set_colour
	mov	rax, QWORD PTR [rsp+24]
	test	rax, rax
	je	.L38
	mov	rsi, rbp
	mov	rdi, rax
	call	xosd_set_colour
.L38:
	mov	edx, 31
	mov	rsi, rbp
	lea	rdi, [rsp+160]
	call	strncpy
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L53:
	mov	r13d, OFFSET FLAT:.LC8
	mov	ebp, OFFSET FLAT:.LC9
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L129:
	mov	ecx, ebx
	mov	edx, OFFSET FLAT:.LC29
	mov	esi, 16
	xor	eax, eax
	mov	r9d, DWORD PTR [rsp+192]
	mov	r8d, DWORD PTR [rsp+196]
	lea	rdi, [rsp+144]
	lea	r12, [rsp+145]
	call	snprintf
	mov	BYTE PTR [rsp+1152], 0
	movsx	rbp, BYTE PTR [rsp+144]
	mov	BYTE PTR [rsp+1408], 0
	mov	r13, QWORD PTR [rsp+56]
	mov	BYTE PTR [rsp+1664], 0
	mov	BYTE PTR [rsp+1920], 0
	mov	BYTE PTR [rsp+2176], 0
	mov	BYTE PTR [rsp+2432], 0
	mov	BYTE PTR [rsp+2688], 0
	mov	BYTE PTR [rsp+2944], 0
	test	bpl, bpl
	je	.L50
	.p2align 4,,10
	.p2align 3
.L49:
	lea	eax, [rbp-48]
	cmp	al, 9
	jbe	.L43
	xor	r14d, r14d
	.p2align 4,,10
	.p2align 3
.L47:
	mov	rbx, r14
	lea	rax, [rsp+1152]
	sal	rbx, 8
	add	rbx, rax
	mov	rdi, rbx
	cmp	bpl, 58
	je	.L130
	call	strlen
	add	r14, 1
	mov	ecx, 32
	mov	WORD PTR [rbx+rax], cx
	cmp	r14, 8
	jne	.L47
	add	r12, 1
	movsx	rbp, BYTE PTR [r12-1]
	test	bpl, bpl
	jne	.L49
.L50:
	mov	rbp, QWORD PTR [rsp+24]
	xor	ebx, ebx
	.p2align 4,,10
	.p2align 3
.L42:
	mov	rcx, rbx
	lea	rax, [rsp+1152]
	mov	esi, ebx
	mov	rdi, rbp
	sal	rcx, 8
	mov	edx, 1
	add	rbx, 1
	add	rcx, rax
	xor	eax, eax
	call	xosd_display
	cmp	rbx, 8
	jne	.L42
	test	r15d, r15d
	je	.L131
.L51:
	mov	r15d, 1
	jmp	.L52
	.p2align 4,,10
	.p2align 3
.L130:
	call	strlen
	mov	rsi, QWORD PTR ascii_colon[0+r14*8]
	add	r14, 1
	lea	rdi, [rbx+rax]
	call	stpcpy
	mov	esi, 32
	mov	WORD PTR [rax], si
	cmp	r14, 8
	jne	.L47
	add	r12, 1
	movsx	rbp, BYTE PTR [r12-1]
	test	bpl, bpl
	jne	.L49
	jmp	.L50
	.p2align 4,,10
	.p2align 3
.L43:
	sal	rbp, 6
	lea	rbx, [rsp+1152]
	add	rbp, OFFSET FLAT:ascii_v-3072
	.p2align 4,,10
	.p2align 3
.L48:
	mov	rdi, rbx
	add	rbp, 8
	call	strlen
	mov	rsi, QWORD PTR [rbp-8]
	lea	rdi, [rbx+rax]
	add	rbx, 256
	call	stpcpy
	mov	edx, 32
	mov	WORD PTR [rax], dx
	cmp	rbx, r13
	jne	.L48
	add	r12, 1
	movsx	rbp, BYTE PTR [r12-1]
	test	bpl, bpl
	jne	.L49
	jmp	.L50
.L131:
	mov	rdi, QWORD PTR [rsp+24]
	call	xosd_show
	jmp	.L51
.L126:
	mov	r14, rbx
	mov	ebx, DWORD PTR [rsp+52]
	mov	rdi, r14
	call	XFree
	mov	rdi, QWORD PTR [rsp+144]
	call	XFree
	xor	esi, esi
	lea	rdi, [rsp+640]
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	jns	.L132
.L32:
	mov	r13d, OFFSET FLAT:.LC10
	mov	ebp, OFFSET FLAT:.LC11
	jmp	.L36
.L123:
	mov	edi, OFFSET FLAT:.LC20
	mov	edx, 34
	mov	esi, 1
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	mov	rdi, QWORD PTR [rsp+8]
	call	XCloseDisplay
.L114:
	add	rsp, 5256
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
.L122:
	.cfi_restore_state
	mov	edx, 33
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC19
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	jmp	.L114
.L132:
	mov	edi, eax
	mov	edx, 4095
	lea	rsi, [rsp+1152]
	call	read
	mov	edi, ebp
	mov	r13, rax
	call	close
	test	r13, r13
	jle	.L32
	mov	BYTE PTR [rsp+1152+r13], 0
	mov	ebp, OFFSET FLAT:.LC11
	mov	r13d, OFFSET FLAT:.LC10
	jmp	.L36
	.cfi_endproc
.LFE36:
	.size	main, .-main
	.section	.rodata.str1.1
.LC30:
	.string	"    "
.LC31:
	.string	" /$$"
.LC32:
	.string	"|__/"
	.section	.rodata
	.align 32
	.type	ascii_colon, @object
	.size	ascii_colon, 64
ascii_colon:
	.quad	.LC30
	.quad	.LC31
	.quad	.LC32
	.quad	.LC30
	.quad	.LC31
	.quad	.LC32
	.quad	.LC30
	.quad	.LC30
	.section	.rodata.str1.1
.LC33:
	.string	"  /$$$$$$ "
.LC34:
	.string	" /$$$_  $$"
.LC35:
	.string	"| $$$$\\ $$"
.LC36:
	.string	"| $$ $$ $$"
.LC37:
	.string	"| $$\\ $$$$"
.LC38:
	.string	"| $$ \\ $$$"
.LC39:
	.string	"|  $$$$$$/"
.LC40:
	.string	" \\______/ "
.LC41:
	.string	"   /$$  "
.LC42:
	.string	" /$$$$  "
.LC43:
	.string	"|_  $$  "
.LC44:
	.string	"  | $$  "
.LC45:
	.string	" /$$$$$$"
.LC46:
	.string	"|______/"
.LC47:
	.string	" /$$__  $$"
.LC48:
	.string	"|__/  \\ $$"
.LC49:
	.string	"  /$$$$$$/"
.LC50:
	.string	" /$$____/ "
.LC51:
	.string	"| $$      "
.LC52:
	.string	"| $$$$$$$$"
.LC53:
	.string	"|________/"
.LC54:
	.string	"   /$$$$$/"
.LC55:
	.string	"  |___  $$"
.LC56:
	.string	" /$$  \\ $$"
.LC57:
	.string	" /$$   /$$"
.LC58:
	.string	"| $$  | $$"
.LC59:
	.string	"|_____  $$"
.LC60:
	.string	"      | $$"
.LC61:
	.string	"      |__/"
.LC62:
	.string	" /$$$$$$$ "
.LC63:
	.string	"| $$____/ "
.LC64:
	.string	"| $$$$$$$ "
.LC65:
	.string	"| $$  \\__/"
.LC66:
	.string	"| $$__  $$"
.LC67:
	.string	"| $$  \\ $$"
.LC68:
	.string	" /$$$$$$$$"
.LC69:
	.string	"|_____ $$/"
.LC70:
	.string	"     /$$/ "
.LC71:
	.string	"    /$$/  "
.LC72:
	.string	"   /$$/   "
.LC73:
	.string	"  /$$/    "
.LC74:
	.string	" /$$/     "
.LC75:
	.string	"|__/      "
.LC76:
	.string	" >$$__  $$"
.LC77:
	.string	"|  $$$$$$$"
.LC78:
	.string	" \\____  $$"
	.section	.rodata
	.align 32
	.type	ascii_v, @object
	.size	ascii_v, 640
ascii_v:
	.quad	.LC33
	.quad	.LC34
	.quad	.LC35
	.quad	.LC36
	.quad	.LC37
	.quad	.LC38
	.quad	.LC39
	.quad	.LC40
	.quad	.LC41
	.quad	.LC42
	.quad	.LC43
	.quad	.LC44
	.quad	.LC44
	.quad	.LC44
	.quad	.LC45
	.quad	.LC46
	.quad	.LC33
	.quad	.LC47
	.quad	.LC48
	.quad	.LC49
	.quad	.LC50
	.quad	.LC51
	.quad	.LC52
	.quad	.LC53
	.quad	.LC33
	.quad	.LC47
	.quad	.LC48
	.quad	.LC54
	.quad	.LC55
	.quad	.LC56
	.quad	.LC39
	.quad	.LC40
	.quad	.LC57
	.quad	.LC58
	.quad	.LC58
	.quad	.LC52
	.quad	.LC59
	.quad	.LC60
	.quad	.LC60
	.quad	.LC61
	.quad	.LC62
	.quad	.LC63
	.quad	.LC51
	.quad	.LC64
	.quad	.LC59
	.quad	.LC56
	.quad	.LC39
	.quad	.LC40
	.quad	.LC33
	.quad	.LC47
	.quad	.LC65
	.quad	.LC64
	.quad	.LC66
	.quad	.LC67
	.quad	.LC39
	.quad	.LC40
	.quad	.LC68
	.quad	.LC69
	.quad	.LC70
	.quad	.LC71
	.quad	.LC72
	.quad	.LC73
	.quad	.LC74
	.quad	.LC75
	.quad	.LC33
	.quad	.LC47
	.quad	.LC67
	.quad	.LC39
	.quad	.LC76
	.quad	.LC67
	.quad	.LC39
	.quad	.LC40
	.quad	.LC33
	.quad	.LC47
	.quad	.LC67
	.quad	.LC77
	.quad	.LC78
	.quad	.LC56
	.quad	.LC39
	.quad	.LC40
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
