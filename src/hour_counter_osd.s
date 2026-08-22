	.file	"hour_counter_osd.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"/home/user"
.LC1:
	.string	"orange"
.LC2:
	.string	"red"
.LC3:
	.string	"green"
.LC4:
	.string	"HOME"
.LC5:
	.string	"%s/.stop_personal_osdx"
.LC6:
	.string	"%s/.xbindkeysrc"
.LC7:
	.string	"%s/.big_hour_counter"
.LC8:
	.string	"%s/.acounter"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC9:
	.string	"/tmp/Contar_Horas_counter_is_run_already.pid"
	.align 8
.LC10:
	.string	"hour_counter_osd: Cannot open X Display\n"
	.align 8
.LC11:
	.string	"hour_counter_osd: Cannot create XOSD\n"
	.section	.rodata.str1.1
.LC12:
	.string	"%04d%02d%02d%02d%02d"
.LC13:
	.string	"r+"
.LC14:
	.string	"w+"
.LC15:
	.string	"\n%s"
.LC16:
	.string	"%4d%2d%2d%2d%2d"
.LC17:
	.string	"%dHORA"
.LC18:
	.string	"_NET_CLIENT_LIST"
.LC19:
	.string	"%dHORAS"
.LC20:
	.string	"ctrl+shift releases"
.LC21:
	.string	"NOT MOUSE"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB37:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	mov	edi, OFFSET FLAT:.LC4
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
	sub	rsp, 9560
	.cfi_def_cfa_offset 9616
	call	getenv
	mov	edx, OFFSET FLAT:.LC5
	mov	esi, 256
	lea	rdi, [rsp+336]
	test	rax, rax
	mov	rbx, rax
	mov	eax, OFFSET FLAT:.LC0
	cmove	rbx, rax
	xor	eax, eax
	mov	rcx, rbx
	call	snprintf
	mov	rcx, rbx
	mov	edx, OFFSET FLAT:.LC6
	xor	eax, eax
	mov	esi, 256
	lea	rdi, [rsp+592]
	call	snprintf
	mov	rcx, rbx
	mov	edx, OFFSET FLAT:.LC7
	xor	eax, eax
	mov	esi, 256
	lea	rdi, [rsp+848]
	call	snprintf
	mov	edx, OFFSET FLAT:.LC8
	xor	eax, eax
	mov	rcx, rbx
	mov	esi, 256
	lea	rdi, [rsp+1104]
	call	snprintf
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	mov	edi, OFFSET FLAT:.LC9
	call	open
	test	eax, eax
	js	.L3
	mov	edi, eax
	call	close
.L3:
	xor	edi, edi
	call	XOpenDisplay
	mov	QWORD PTR [rsp+24], rax
	test	rax, rax
	je	.L140
	mov	rcx, rax
	movsx	rax, DWORD PTR [rax+224]
	mov	edi, 8
	sal	rax, 7
	add	rax, QWORD PTR [rcx+232]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rsp+48], rax
	call	xosd_create
	mov	QWORD PTR [rsp+40], rax
	test	rax, rax
	je	.L141
	mov	rbx, QWORD PTR [rsp+40]
	mov	esi, 1
	lea	r12, [rsp+5456]
	lea	rbp, [rsp+5455]
	lea	r13, [rsp+1360]
	mov	rdi, rbx
	call	xosd_set_pos
	xor	esi, esi
	mov	rdi, rbx
	call	xosd_set_align
	mov	esi, 1
	mov	rdi, rbx
	call	xosd_set_shadow_offset
	or	esi, -1
	mov	rdi, rbx
	call	xosd_set_timeout
	xor	edi, edi
	call	time
	mov	DWORD PTR [rsp+20], 0
	pxor	xmm0, xmm0
	mov	QWORD PTR [rsp+32], rax
	or	eax, -1
	mov	DWORD PTR [rsp+60], eax
	mov	DWORD PTR [rsp+56], eax
	movaps	XMMWORD PTR [rsp+144], xmm0
	movaps	XMMWORD PTR [rsp+160], xmm0
	.p2align 4,,10
	.p2align 3
.L7:
	xor	esi, esi
	lea	rdi, [rsp+336]
	call	access
	test	eax, eax
	jne	.L8
	mov	r10d, DWORD PTR [rsp+20]
	test	r10d, r10d
	jne	.L142
.L9:
	mov	edi, 200000
	call	usleep
	mov	DWORD PTR [rsp+20], 0
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L8:
	sub	rsp, 8
	.cfi_def_cfa_offset 9624
	lea	rax, [rsp+88]
	push	rax
	.cfi_def_cfa_offset 9632
	lea	rax, [rsp+92]
	push	rax
	.cfi_def_cfa_offset 9640
	lea	rax, [rsp+96]
	push	rax
	.cfi_def_cfa_offset 9648
	mov	rsi, QWORD PTR [rsp+80]
	mov	rdi, QWORD PTR [rsp+56]
	lea	r9, [rsp+100]
	lea	r8, [rsp+96]
	lea	rcx, [rsp+144]
	lea	rdx, [rsp+136]
	call	XQueryPointer
	add	rsp, 32
	.cfi_def_cfa_offset 9616
	test	eax, eax
	je	.L11
	mov	ebx, DWORD PTR [rsp+64]
	mov	r14d, DWORD PTR [rsp+68]
	cmp	ebx, DWORD PTR [rsp+56]
	jne	.L12
	cmp	DWORD PTR [rsp+60], r14d
	je	.L11
.L12:
	xor	edi, edi
	call	time
	mov	DWORD PTR [rsp+60], r14d
	mov	QWORD PTR [rsp+32], rax
	mov	DWORD PTR [rsp+56], ebx
.L11:
	xor	edi, edi
	call	time
	mov	rbx, rax
	sub	eax, DWORD PTR [rsp+32]
	cmp	eax, 4
	jg	.L143
	lea	rdi, [rsp+848]
	call	unlink
	mov	eax, DWORD PTR [rsp+20]
	test	eax, eax
	jne	.L144
.L60:
	mov	edi, 100000
	call	usleep
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L142:
	mov	rdi, QWORD PTR [rsp+40]
	call	xosd_hide
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L143:
	xor	eax, eax
	mov	edx, 420
	mov	esi, 577
	lea	rdi, [rsp+848]
	call	open
	test	eax, eax
	js	.L14
	mov	edi, eax
	call	close
.L14:
	lea	rsi, [rsp+208]
	lea	rdi, [rsp+120]
	mov	QWORD PTR [rsp+120], rbx
	call	localtime_r
	mov	edx, OFFSET FLAT:.LC12
	mov	esi, 32
	mov	eax, DWORD PTR [rsp+228]
	lea	ecx, [rax+1900]
	mov	eax, DWORD PTR [rsp+212]
	push	rax
	.cfi_def_cfa_offset 9624
	mov	eax, DWORD PTR [rsp+224]
	push	rax
	.cfi_def_cfa_offset 9632
	mov	eax, DWORD PTR [rsp+240]
	mov	r9d, DWORD PTR [rsp+236]
	lea	r8d, [rax+1]
	xor	eax, eax
	lea	rdi, [rsp+192]
	call	snprintf
	lea	rdi, [rsp+1120]
	mov	esi, OFFSET FLAT:.LC13
	call	fopen
	pop	r8
	.cfi_def_cfa_offset 9624
	pop	r9
	.cfi_def_cfa_offset 9616
	mov	rbx, rax
	test	rax, rax
	je	.L145
	mov	ecx, 126
	xor	eax, eax
	pxor	xmm0, xmm0
	xor	r14d, r14d
	lea	rdi, [rsp+1376]
	movaps	XMMWORD PTR [rsp+1360], xmm0
	rep stosq
	.p2align 4,,10
	.p2align 3
.L18:
	mov	rdx, rbx
	mov	esi, 1024
	mov	rdi, r12
	call	fgets
	test	rax, rax
	je	.L27
	movzx	eax, BYTE PTR [rsp+5456]
	lea	rdx, [r12+1]
	test	al, al
	je	.L29
	.p2align 4,,10
	.p2align 3
.L20:
	cmp	al, 46
	sete	al
	add	rdx, 1
	movzx	eax, al
	add	r14d, eax
	movzx	eax, BYTE PTR [rdx-1]
	test	al, al
	jne	.L20
.L29:
	mov	rdx, r12
.L21:
	mov	ecx, DWORD PTR [rdx]
	add	rdx, 4
	lea	eax, [rcx-16843009]
	not	ecx
	and	eax, ecx
	and	eax, -2139062144
	je	.L21
	mov	ecx, eax
	shr	ecx, 16
	test	eax, 32896
	cmove	eax, ecx
	lea	rcx, [rdx+2]
	cmove	rdx, rcx
	mov	esi, eax
	add	sil, al
	sbb	rdx, 3
	sub	rdx, r12
	je	.L18
	movzx	eax, BYTE PTR [rsp+5455+rdx]
	cmp	al, 13
	je	.L74
	cmp	al, 10
	jne	.L24
.L74:
	lea	rax, [r12-2+rdx]
	.p2align 4,,10
	.p2align 3
.L108:
	mov	BYTE PTR [rax+1], 0
	cmp	rax, rbp
	je	.L18
	movzx	edx, BYTE PTR [rax]
	sub	rax, 1
	cmp	dl, 10
	je	.L108
	cmp	dl, 13
	je	.L108
.L24:
	mov	edx, 1023
	mov	rsi, r12
	mov	rdi, r13
	call	strncpy
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L144:
	mov	rdi, QWORD PTR [rsp+40]
	call	xosd_hide
	mov	DWORD PTR [rsp+20], 0
	jmp	.L60
	.p2align 4,,10
	.p2align 3
.L27:
	mov	r10, r13
.L30:
	mov	edx, DWORD PTR [r10]
	add	r10, 4
	lea	eax, [rdx-16843009]
	not	edx
	and	eax, edx
	and	eax, -2139062144
	je	.L30
	mov	edx, eax
	shr	edx, 16
	test	eax, 32896
	cmove	eax, edx
	lea	rdx, [r10+2]
	cmove	r10, rdx
	mov	ecx, eax
	add	cl, al
	sbb	r10, 3
	sub	r10, r13
	cmp	r10, 11
	jbe	.L75
	lea	rdi, [rsp+128]
	mov	edx, 12
	mov	rsi, r13
	mov	QWORD PTR [rsp+8], r10
	call	strncpy
	sub	rsp, 8
	.cfi_def_cfa_offset 9624
	mov	esi, OFFSET FLAT:.LC16
	mov	BYTE PTR [rsp+148], 0
	lea	rax, [rsp+108]
	push	rax
	.cfi_def_cfa_offset 9632
	xor	eax, eax
	lea	r9, [rsp+112]
	lea	r8, [rsp+108]
	lea	rcx, [rsp+104]
	lea	rdx, [rsp+100]
	lea	rdi, [rsp+144]
	call	__isoc99_sscanf
	pop	rsi
	.cfi_def_cfa_offset 9624
	pop	rdi
	.cfi_def_cfa_offset 9616
	cmp	eax, 5
	je	.L146
.L34:
	mov	rdi, rbx
	call	fclose
	cmp	r14d, 1
	je	.L147
.L17:
	mov	ecx, r14d
	mov	edx, OFFSET FLAT:.LC19
	mov	esi, 64
	xor	eax, eax
	lea	rdi, [rsp+272]
	call	snprintf
.L41:
	movzx	eax, BYTE PTR [rsp+272]
	lea	rcx, [rsp+273]
	mov	BYTE PTR [rsp+1360], 0
	mov	BYTE PTR [rsp+1872], 0
	mov	BYTE PTR [rsp+2384], 0
	mov	BYTE PTR [rsp+2896], 0
	mov	BYTE PTR [rsp+3408], 0
	mov	BYTE PTR [rsp+3920], 0
	mov	BYTE PTR [rsp+4432], 0
	mov	BYTE PTR [rsp+4944], 0
	mov	QWORD PTR [rsp+8], rcx
	test	al, al
	je	.L48
	.p2align 4,,10
	.p2align 3
.L47:
	lea	edx, [rax-48]
	cmp	dl, 9
	jbe	.L148
	mov	ecx, OFFSET FLAT:ascii_colon
	cmp	al, 58
	je	.L43
	and	eax, -33
	mov	ecx, OFFSET FLAT:ascii_H
	cmp	al, 72
	je	.L43
	mov	ecx, OFFSET FLAT:ascii_O
	cmp	al, 79
	je	.L43
	mov	ecx, OFFSET FLAT:ascii_R
	cmp	al, 82
	je	.L43
	mov	ecx, OFFSET FLAT:ascii_A
	cmp	al, 65
	je	.L43
	cmp	al, 83
	mov	ecx, OFFSET FLAT:ascii_S
	mov	eax, OFFSET FLAT:ascii_colon
	cmovne	rcx, rax
	.p2align 4,,10
	.p2align 3
.L43:
	mov	r14, rcx
	lea	rbx, [r13+4096]
	mov	r15, r13
	.p2align 4,,10
	.p2align 3
.L46:
	mov	rdi, r15
.L44:
	mov	edx, DWORD PTR [rdi]
	add	rdi, 4
	lea	eax, [rdx-16843009]
	not	edx
	and	eax, edx
	and	eax, -2139062144
	je	.L44
	mov	edx, eax
	shr	edx, 16
	test	eax, 32896
	cmove	eax, edx
	lea	rdx, [rdi+2]
	cmove	rdi, rdx
	mov	esi, eax
	add	sil, al
	mov	rsi, QWORD PTR [r14]
	sbb	rdi, 3
	add	r15, 512
	add	r14, 8
	call	stpcpy
	mov	ecx, 32
	mov	WORD PTR [rax], cx
	cmp	rbx, r15
	jne	.L46
	add	QWORD PTR [rsp+8], 1
	mov	rax, QWORD PTR [rsp+8]
	movzx	eax, BYTE PTR [rax-1]
	test	al, al
	jne	.L47
.L48:
	mov	rdi, QWORD PTR [rsp+24]
	mov	edx, 1
	mov	esi, OFFSET FLAT:.LC18
	call	XInternAtom
	test	rax, rax
	je	.L55
	lea	rcx, [rsp+208]
	xor	r9d, r9d
	mov	r8d, 1024
	mov	rdx, rax
	mov	QWORD PTR [rsp+208], 0
	push	rcx
	.cfi_def_cfa_offset 9624
	lea	rcx, [rsp+184]
	push	rcx
	.cfi_def_cfa_offset 9632
	lea	rcx, [rsp+144]
	push	rcx
	.cfi_def_cfa_offset 9640
	lea	rcx, [rsp+124]
	push	rcx
	.cfi_def_cfa_offset 9648
	lea	rcx, [rsp+152]
	push	rcx
	.cfi_def_cfa_offset 9656
	xor	ecx, ecx
	push	33
	.cfi_def_cfa_offset 9664
	mov	rsi, QWORD PTR [rsp+96]
	mov	rdi, QWORD PTR [rsp+72]
	call	XGetWindowProperty
	add	rsp, 48
	.cfi_def_cfa_offset 9616
	test	eax, eax
	jne	.L55
	mov	r14, QWORD PTR [rsp+208]
	test	r14, r14
	je	.L55
	cmp	QWORD PTR [rsp+128], 0
	je	.L49
	xor	ebx, ebx
	.p2align 4,,10
	.p2align 3
.L54:
	mov	rsi, QWORD PTR [r14+rbx*8]
	mov	rdx, r12
	mov	rdi, QWORD PTR [rsp+24]
	mov	QWORD PTR [rsp+5456], 0
	call	XFetchName
	test	eax, eax
	jle	.L50
	mov	r15, QWORD PTR [rsp+5456]
	test	r15, r15
	je	.L50
	mov	esi, OFFSET FLAT:.LC20
	mov	rdi, r15
	call	strstr
	test	rax, rax
	jne	.L149
	mov	rdi, r15
	call	XFree
.L50:
	add	rbx, 1
	cmp	rbx, QWORD PTR [rsp+128]
	jb	.L54
	mov	r14, QWORD PTR [rsp+208]
.L49:
	mov	rdi, r14
	call	XFree
	.p2align 4,,10
	.p2align 3
.L55:
	xor	esi, esi
	lea	rdi, [rsp+592]
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L61
	mov	edi, eax
	mov	edx, 4095
	mov	rsi, r12
	call	read
	mov	edi, ebx
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L61
	mov	esi, OFFSET FLAT:.LC21
	mov	rdi, r12
	mov	ebx, OFFSET FLAT:.LC3
	mov	BYTE PTR [rsp+5456+r14], 0
	call	strstr
	test	rax, rax
	mov	eax, OFFSET FLAT:.LC1
	cmove	rbx, rax
.L56:
	mov	rsi, rbx
	lea	rdi, [rsp+144]
	call	strcmp
	test	eax, eax
	jne	.L150
.L57:
	mov	r14, QWORD PTR [rsp+40]
	xor	ebx, ebx
	.p2align 4,,10
	.p2align 3
.L58:
	mov	rcx, rbx
	mov	esi, ebx
	mov	edx, 1
	mov	rdi, r14
	sal	rcx, 9
	xor	eax, eax
	add	rbx, 1
	add	rcx, r13
	call	xosd_display
	cmp	rbx, 8
	jne	.L58
	mov	edx, DWORD PTR [rsp+20]
	test	edx, edx
	je	.L151
.L59:
	mov	DWORD PTR [rsp+20], 1
	jmp	.L60
	.p2align 4,,10
	.p2align 3
.L148:
	movsx	ecx, al
	sub	ecx, 48
	movsx	rcx, ecx
	sal	rcx, 6
	add	rcx, OFFSET FLAT:ascii_v
	jmp	.L43
.L147:
	mov	ecx, 1
	mov	edx, OFFSET FLAT:.LC17
	mov	esi, 64
	xor	eax, eax
	lea	rdi, [rsp+272]
	call	snprintf
	jmp	.L41
.L150:
	mov	rdi, QWORD PTR [rsp+40]
	mov	rsi, rbx
	call	xosd_set_colour
	mov	edx, 31
	mov	rsi, rbx
	lea	rdi, [rsp+144]
	call	strncpy
	jmp	.L57
.L151:
	mov	rdi, QWORD PTR [rsp+40]
	call	xosd_show
	jmp	.L59
.L146:
	mov	eax, DWORD PTR [rsp+84]
	pxor	xmm0, xmm0
	lea	rdi, [rsp+272]
	mov	QWORD PTR [rsp+320], 0
	movaps	XMMWORD PTR [rsp+288], xmm0
	sub	eax, 1900
	movaps	XMMWORD PTR [rsp+272], xmm0
	mov	DWORD PTR [rsp+292], eax
	mov	eax, DWORD PTR [rsp+88]
	movaps	XMMWORD PTR [rsp+304], xmm0
	mov	DWORD PTR [rsp+304], -1
	sub	eax, 1
	mov	DWORD PTR [rsp+288], eax
	mov	eax, DWORD PTR [rsp+92]
	mov	DWORD PTR [rsp+284], eax
	mov	eax, DWORD PTR [rsp+96]
	mov	DWORD PTR [rsp+280], eax
	mov	eax, DWORD PTR [rsp+100]
	mov	DWORD PTR [rsp+276], eax
	call	mktime
	cmp	rax, -1
	je	.L34
	mov	r10, QWORD PTR [rsp+8]
	mov	rcx, QWORD PTR [rsp+120]
	lea	edx, [r10-12]
	imul	edx, edx, 3600
	movsx	rdx, edx
	add	rax, rdx
	mov	rdx, rcx
	sub	rdx, rax
	lea	rsi, [rdx-3600]
	cmp	rsi, 3599
	jbe	.L152
	cmp	rax, rcx
	jg	.L75
	cmp	rdx, 7199
	jle	.L34
.L75:
	xor	esi, esi
	mov	rdi, rbx
	mov	edx, 2
	call	fseek
	mov	esi, OFFSET FLAT:.LC15
	mov	rdi, rbx
	xor	eax, eax
	lea	rdx, [rsp+176]
	call	fprintf
	jmp	.L34
.L61:
	mov	ebx, OFFSET FLAT:.LC1
	jmp	.L56
.L145:
	mov	esi, OFFSET FLAT:.LC14
	lea	rdi, [rsp+1104]
	call	fopen
	mov	rbx, rax
	test	rax, rax
	je	.L138
	lea	rdi, [rsp+176]
	mov	rsi, rax
	call	fputs
	mov	rdi, rbx
	call	fclose
.L138:
	xor	r14d, r14d
	jmp	.L17
.L149:
	mov	rdi, r15
	call	XFree
	mov	rdi, QWORD PTR [rsp+208]
	call	XFree
	xor	esi, esi
	lea	rdi, [rsp+592]
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	jns	.L153
.L52:
	mov	ebx, OFFSET FLAT:.LC2
	jmp	.L56
.L152:
	mov	edx, 2
	xor	esi, esi
	mov	rdi, rbx
	add	r14d, 1
	call	fseek
	mov	rsi, rbx
	mov	edi, 46
	call	fputc
	jmp	.L34
.L141:
	mov	edi, OFFSET FLAT:.LC11
	mov	edx, 37
	mov	esi, 1
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	mov	rdi, QWORD PTR [rsp+24]
	call	XCloseDisplay
.L128:
	add	rsp, 9560
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
	mov	edx, 40
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC10
	mov	rcx, QWORD PTR stderr[rip]
	call	fwrite
	jmp	.L128
.L153:
	mov	edi, eax
	mov	edx, 4095
	mov	rsi, r12
	call	read
	mov	edi, ebx
	mov	r14, rax
	call	close
	test	r14, r14
	jle	.L52
	mov	BYTE PTR [rsp+5456+r14], 0
	mov	ebx, OFFSET FLAT:.LC2
	jmp	.L56
	.cfi_endproc
.LFE37:
	.size	main, .-main
	.section	.rodata.str1.1
.LC22:
	.string	"  /$$$$$$ "
.LC23:
	.string	" /$$__  $$"
.LC24:
	.string	"| $$  \\__/"
.LC25:
	.string	"|  $$$$$$ "
.LC26:
	.string	" \\____  $$"
.LC27:
	.string	" /$$  \\ $$"
.LC28:
	.string	"|  $$$$$$/"
.LC29:
	.string	" \\______/ "
	.data
	.align 32
	.type	ascii_S, @object
	.size	ascii_S, 64
ascii_S:
	.quad	.LC22
	.quad	.LC23
	.quad	.LC24
	.quad	.LC25
	.quad	.LC26
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.section	.rodata.str1.1
.LC30:
	.string	"| $$  \\ $$"
.LC31:
	.string	"| $$$$$$$$"
.LC32:
	.string	"| $$__  $$"
.LC33:
	.string	"| $$  | $$"
.LC34:
	.string	"|__/  |__/"
	.data
	.align 32
	.type	ascii_A, @object
	.size	ascii_A, 64
ascii_A:
	.quad	.LC22
	.quad	.LC23
	.quad	.LC30
	.quad	.LC31
	.quad	.LC32
	.quad	.LC33
	.quad	.LC33
	.quad	.LC34
	.section	.rodata.str1.1
.LC35:
	.string	" /$$$$$$$ "
.LC36:
	.string	"| $$$$$$$/"
	.data
	.align 32
	.type	ascii_R, @object
	.size	ascii_R, 64
ascii_R:
	.quad	.LC35
	.quad	.LC32
	.quad	.LC30
	.quad	.LC36
	.quad	.LC32
	.quad	.LC30
	.quad	.LC33
	.quad	.LC34
	.align 32
	.type	ascii_O, @object
	.size	ascii_O, 64
ascii_O:
	.quad	.LC22
	.quad	.LC23
	.quad	.LC30
	.quad	.LC33
	.quad	.LC33
	.quad	.LC33
	.quad	.LC28
	.quad	.LC29
	.section	.rodata.str1.1
.LC37:
	.string	" /$$   /$$"
	.data
	.align 32
	.type	ascii_H, @object
	.size	ascii_H, 64
ascii_H:
	.quad	.LC37
	.quad	.LC33
	.quad	.LC33
	.quad	.LC31
	.quad	.LC32
	.quad	.LC33
	.quad	.LC33
	.quad	.LC34
	.section	.rodata.str1.1
.LC38:
	.string	"    "
.LC39:
	.string	" /$$"
.LC40:
	.string	"|__/"
	.data
	.align 32
	.type	ascii_colon, @object
	.size	ascii_colon, 64
ascii_colon:
	.quad	.LC38
	.quad	.LC39
	.quad	.LC40
	.quad	.LC38
	.quad	.LC39
	.quad	.LC40
	.quad	.LC38
	.quad	.LC38
	.section	.rodata.str1.1
.LC41:
	.string	" /$$$_  $$"
.LC42:
	.string	"| $$$$\\ $$"
.LC43:
	.string	"| $$ $$ $$"
.LC44:
	.string	"| $$\\ $$$$"
.LC45:
	.string	"| $$ \\ $$$"
.LC46:
	.string	"   /$$    "
.LC47:
	.string	" /$$$$    "
.LC48:
	.string	"|_  $$    "
.LC49:
	.string	"  | $$    "
.LC50:
	.string	" /$$$$$$  "
.LC51:
	.string	"|______/  "
.LC52:
	.string	"|__/  \\ $$"
.LC53:
	.string	"  /$$$$$$/"
.LC54:
	.string	" /$$____/ "
.LC55:
	.string	"| $$      "
.LC56:
	.string	"|________/"
.LC57:
	.string	"   /$$$$$/"
.LC58:
	.string	"  |___  $$"
.LC59:
	.string	"|_____  $$"
.LC60:
	.string	"      | $$"
.LC61:
	.string	"      |__/"
.LC62:
	.string	"| $$____/ "
.LC63:
	.string	"| $$$$$$$ "
.LC64:
	.string	" /$$$$$$$$"
.LC65:
	.string	"|_____ $$/"
.LC66:
	.string	"     /$$/ "
.LC67:
	.string	"    /$$/  "
.LC68:
	.string	"   /$$/   "
.LC69:
	.string	"  /$$/    "
.LC70:
	.string	" /$$/     "
.LC71:
	.string	"|__/      "
.LC72:
	.string	" >$$__  $$"
.LC73:
	.string	"|  $$$$$$$"
	.data
	.align 32
	.type	ascii_v, @object
	.size	ascii_v, 640
ascii_v:
	.quad	.LC22
	.quad	.LC41
	.quad	.LC42
	.quad	.LC43
	.quad	.LC44
	.quad	.LC45
	.quad	.LC28
	.quad	.LC29
	.quad	.LC46
	.quad	.LC47
	.quad	.LC48
	.quad	.LC49
	.quad	.LC49
	.quad	.LC49
	.quad	.LC50
	.quad	.LC51
	.quad	.LC22
	.quad	.LC23
	.quad	.LC52
	.quad	.LC53
	.quad	.LC54
	.quad	.LC55
	.quad	.LC31
	.quad	.LC56
	.quad	.LC22
	.quad	.LC23
	.quad	.LC52
	.quad	.LC57
	.quad	.LC58
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.quad	.LC37
	.quad	.LC33
	.quad	.LC33
	.quad	.LC31
	.quad	.LC59
	.quad	.LC60
	.quad	.LC60
	.quad	.LC61
	.quad	.LC35
	.quad	.LC62
	.quad	.LC55
	.quad	.LC63
	.quad	.LC59
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.quad	.LC22
	.quad	.LC23
	.quad	.LC24
	.quad	.LC63
	.quad	.LC32
	.quad	.LC30
	.quad	.LC28
	.quad	.LC29
	.quad	.LC64
	.quad	.LC65
	.quad	.LC66
	.quad	.LC67
	.quad	.LC68
	.quad	.LC69
	.quad	.LC70
	.quad	.LC71
	.quad	.LC22
	.quad	.LC23
	.quad	.LC30
	.quad	.LC28
	.quad	.LC72
	.quad	.LC30
	.quad	.LC28
	.quad	.LC29
	.quad	.LC22
	.quad	.LC23
	.quad	.LC30
	.quad	.LC73
	.quad	.LC26
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
