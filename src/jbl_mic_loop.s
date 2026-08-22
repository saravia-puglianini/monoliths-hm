.intel_syntax noprefix
.global _start

/* Constantes Linux x86_64 */
.equ SYS_nanosleep, 35
.equ SYS_fork,      57
.equ SYS_execve,    59
.equ SYS_exit,      60
.equ SYS_wait4,     61
.equ SYS_open,      2
.equ SYS_close,     3
.equ SYS_dup2,      33

.equ O_WRONLY,      1

.section .rodata
amixer_path:        .asciz "/usr/bin/amixer"
arg_c:              .asciz "-c"
arg_card:           .asciz "Wireless"
arg_sset:           .asciz "sset"
arg_mic:            .asciz "Mic"
arg_vol:            .asciz "100%"
arg_unmute:         .asciz "unmute"
dev_null:           .asciz "/dev/null"

/* 500ms sleep (500,000,000 ns) */
timespec_500ms:
    .quad 0
    .quad 500000000

.section .bss
.align 8
argv_amixer:        .zero 80

.section .text

run_amixer_once:
    push rbp
    mov rbp, rsp
    push rbx

    /* fork() */
    mov rax, SYS_fork
    syscall
    test rax, rax
    js .Lfork_err
    jnz .Lparent_wait

    /* Child process: redirect stdout/stderr to /dev/null */
    mov rax, SYS_open
    lea rdi, [rip + dev_null]
    mov rsi, O_WRONLY
    xor rdx, rdx
    syscall
    test rax, rax
    js .Ldo_exec

    mov r8, rax /* fd /dev/null */

    mov rax, SYS_dup2
    mov rdi, r8
    mov rsi, 1 /* stdout */
    syscall

    mov rax, SYS_dup2
    mov rdi, r8
    mov rsi, 2 /* stderr */
    syscall

    mov rax, SYS_close
    mov rdi, r8
    syscall

.Ldo_exec:
    /* Prepare argv: amixer -c Wireless sset Mic 100% unmute NULL */
    lea rbx, [rip + argv_amixer]
    lea rax, [rip + amixer_path]
    mov [rbx], rax
    lea rax, [rip + arg_c]
    mov [rbx + 8], rax
    lea rax, [rip + arg_card]
    mov [rbx + 16], rax
    lea rax, [rip + arg_sset]
    mov [rbx + 24], rax
    lea rax, [rip + arg_mic]
    mov [rbx + 32], rax
    lea rax, [rip + arg_vol]
    mov [rbx + 40], rax
    lea rax, [rip + arg_unmute]
    mov [rbx + 48], rax
    mov qword ptr [rbx + 56], 0

    mov rax, SYS_execve
    lea rdi, [rip + amixer_path]
    lea rsi, [rip + argv_amixer]
    xor rdx, rdx
    syscall

    /* If execve fails, exit child */
    mov rax, SYS_exit
    mov rdi, 1
    syscall

.Lparent_wait:
    /* wait4(pid, NULL, 0, NULL) */
    mov rdi, rax
    xor rsi, rsi
    xor rdx, rdx
    xor r10, r10
    mov rax, SYS_wait4
    syscall

.Lfork_err:
    pop rbx
    pop rbp
    ret

_start:
    /* Loop forever running amixer every 500ms */
.Lmain_loop:
    call run_amixer_once

    /* nanosleep(500ms) */
    mov rax, SYS_nanosleep
    lea rdi, [rip + timespec_500ms]
    xor rsi, rsi
    syscall

    jmp .Lmain_loop
