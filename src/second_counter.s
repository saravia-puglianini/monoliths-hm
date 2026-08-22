.intel_syntax noprefix
.global _start

/* Constantes Linux x86_64 */
.equ SYS_write,     1
.equ SYS_nanosleep, 35
.equ SYS_exit,      60

.equ BAR_LENGTH,    20

.section .rodata
usage_msg:      .asciz "Uso: simple_second_counter <segundos>\n"
bar_start:      .asciz "\r["
bar_end:        .asciz "]"
newline:        .asciz "\n"

.section .bss
.align 8
buf_bar:        .zero 64
ts_step:        .zero 16

.section .text

/* Convierte string a int en rax */
str_to_int:
    xor rax, rax
.Latoi_loop:
    movzx edx, byte ptr [rdi]
    test dl, dl
    jz .Latoi_done
    cmp dl, '0'
    jb .Latoi_done
    cmp dl, '9'
    ja .Latoi_done
    sub dl, '0'
    imul rax, 10
    add rax, rdx
    inc rdi
    jmp .Latoi_loop
.Latoi_done:
    ret

_start:
    pop rcx         /* argc */
    cmp rcx, 2
    jl .Lshow_usage

    pop rdi         /* argv[0] */
    pop rdi         /* argv[1] = DURATION */

    call str_to_int
    test rax, rax
    jle .Lexit_ok

    /* total_ns = rax * 1,000,000,000 */
    mov r8, 1000000000
    imul rax, r8
    /* step_ns = total_ns / BAR_LENGTH */
    xor rdx, rdx
    mov r9, BAR_LENGTH
    div r9
    mov r12, rax    /* step_ns en r12 */

    /* Configurar timespec en .bss */
    /* sec = step_ns / 1,000,000,000 */
    mov rax, r12
    xor rdx, rdx
    mov r8, 1000000000
    div r8
    lea rbx, [rip + ts_step]
    mov [rbx], rax       /* tv_sec */
    mov [rbx + 8], rdx   /* tv_nsec */

    xor r13, r13        /* i = 0 hasta BAR_LENGTH */

.Ldraw_loop:
    /* Construir buffer: '\r', '[', '=' x i, '_' x (20-i), ']' */
    lea rdi, [rip + buf_bar]
    mov byte ptr [rdi], '\r'
    mov byte ptr [rdi + 1], '['
    add rdi, 2

    /* Llenar '=' */
    mov rcx, r13
.Lfill_eq:
    test rcx, rcx
    jz .Lfill_under_start
    mov byte ptr [rdi], '='
    inc rdi
    dec rcx
    jmp .Lfill_eq

.Lfill_under_start:
    mov rcx, BAR_LENGTH
    sub rcx, r13
.Lfill_under:
    test rcx, rcx
    jz .Lfinish_bar
    mov byte ptr [rdi], '_'
    inc rdi
    dec rcx
    jmp .Lfill_under

.Lfinish_bar:
    mov byte ptr [rdi], ']'
    inc rdi

    /* Calcular longitud */
    lea rax, [rip + buf_bar]
    mov rdx, rdi
    sub rdx, rax        /* len en rdx */

    /* write(1, buf_bar, len) */
    mov rax, SYS_write
    mov rdi, 1
    lea rsi, [rip + buf_bar]
    syscall

    /* nanosleep(&ts_step, NULL) */
    mov rax, SYS_nanosleep
    lea rdi, [rip + ts_step]
    xor rsi, rsi
    syscall

    inc r13
    cmp r13, BAR_LENGTH
    jle .Ldraw_loop

    /* write(1, "\n", 1) */
    mov rax, SYS_write
    mov rdi, 1
    lea rsi, [rip + newline]
    mov rdx, 1
    syscall

.Lexit_ok:
    mov rax, SYS_exit
    mov rdi, 0
    syscall

.Lshow_usage:
    mov rax, SYS_write
    mov rdi, 2
    lea rsi, [rip + usage_msg]
    mov rdx, 38
    syscall

    mov rax, SYS_exit
    mov rdi, 1
    syscall
