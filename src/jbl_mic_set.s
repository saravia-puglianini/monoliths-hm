.intel_syntax noprefix
.global _start

/* Constantes Linux x86_64 */
.equ SYS_execve,    59
.equ SYS_exit,      60

.section .rodata
amixer_path:        .asciz "/usr/bin/amixer"
arg_c:              .asciz "-c"
arg_card:           .asciz "Wireless"
arg_sset:           .asciz "sset"
arg_mic:            .asciz "Mic"
arg_vol:            .asciz "100%"
arg_unmute:         .asciz "unmute"

.section .bss
.align 8
argv_amixer:        .zero 80

.section .text
_start:
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

    mov rax, SYS_exit
    mov rdi, 0
    syscall
