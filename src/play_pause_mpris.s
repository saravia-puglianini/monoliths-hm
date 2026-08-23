	.file	"play_pause_mpris.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames 2>/dev/null"
	.section	.rodata.str1.1
.LC2:
	.string	"org.mpris.MediaPlayer2."
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"org.mpris.MediaPlayer2.Player.PlayPause"
	.section	.rodata.str1.1
.LC4:
	.string	"/org/mpris/MediaPlayer2"
.LC5:
	.string	"--dest"
.LC6:
	.string	"dbus-send"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, OFFSET FLAT:.LC1
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 536
	.cfi_def_cfa_offset 560
	call	popen
	test	rax, rax
	je	.L7
	mov	rbp, rax
	.p2align 4,,10
	.p2align 3
.L3:
	mov	rdx, rbp
	mov	esi, 512
	lea	rdi, [rsp+16]
	call	fgets
	test	rax, rax
	je	.L16
	mov	esi, OFFSET FLAT:.LC2
	lea	rdi, [rsp+16]
	call	strstr
	mov	rbx, rax
	test	rax, rax
	je	.L3
	mov	esi, 34
	mov	rdi, rax
	call	strchr
	test	rax, rax
	je	.L3
	mov	BYTE PTR [rax], 0
	call	fork
	test	eax, eax
	je	.L17
	xor	edx, edx
	lea	rsi, [rsp+12]
	mov	edi, eax
	call	waitpid
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L16:
	mov	rdi, rbp
	call	pclose
	xor	eax, eax
.L1:
	add	rsp, 536
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
.L7:
	.cfi_restore_state
	mov	eax, 1
	jmp	.L1
.L17:
	push	rdx
	.cfi_def_cfa_offset 568
	mov	esi, OFFSET FLAT:.LC6
	mov	r9d, OFFSET FLAT:.LC3
	mov	rcx, rbx
	push	0
	.cfi_def_cfa_offset 576
	mov	rdi, rsi
	mov	r8d, OFFSET FLAT:.LC4
	mov	edx, OFFSET FLAT:.LC5
	call	execlp
	mov	edi, 1
	call	_exit
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
