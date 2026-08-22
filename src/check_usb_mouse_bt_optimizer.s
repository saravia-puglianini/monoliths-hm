/*
 * check_usb_mouse_bt_optimizer.s
 * Assembly x86_64 (Linux syscalls)
 * 
 * 1. Lee /proc/bus/input/devices para buscar "Logitech USB Optical Mouse".
 * 2. Si lo encuentra:
 *    - Imprime mensaje de detección.
 *    - Apaga/mata servicio bluetooth (/etc/init.d/bluetooth stop, killall bluetoothd).
 *    - Bloquea rfkill (rfkill block bluetooth).
 *    - Descarga módulos bluetooth (modprobe -r bnep btusb btrtl btmtk btintel btbcm bluetooth).
 *    - Sale con código 0.
 * 3. Si NO lo encuentra:
 *    - Imprime mensaje indicando que no está conectado el Logitech USB Optical Mouse.
 *    - Sale con código 1 (permitiendo al .xinitrc ejecutar el fallback del mouse bluetooth).
 */

.global _start
.intel_syntax noprefix

.section .data
file_input_devices:
    .asciz "/proc/bus/input/devices"

target_mouse_str:
    .asciz "Logitech USB Optical Mouse"

msg_found:
    .asciz "[ASM] Logitech USB Optical Mouse DETECTADO. Optimizando: apagando servicios y modulos Bluetooth...\n"
len_msg_found = . - msg_found

msg_not_found:
    .asciz "[ASM] Logitech USB Optical Mouse NO detectado. Manteniendo configuracion Bluetooth por defecto.\n"
len_msg_not_found = . - msg_not_found

msg_done:
    .asciz "[ASM] Bluetooth detenido y modulos descargados correctamente.\n"
len_msg_done = . - msg_done

/* Comandos para doas/sh */
sh_path:
    .asciz "/bin/sh"
sh_arg_c:
    .asciz "-c"
cmd_disable_bt:
    .asciz "doas /etc/init.d/bluetooth stop 2>/dev/null; doas killall -9 bluetoothd 2>/dev/null; doas hciconfig hci0 down 2>/dev/null; doas rfkill block bluetooth 2>/dev/null; sleep 0.2; doas modprobe -r bnep 2>/dev/null; doas modprobe -r btusb 2>/dev/null; doas modprobe -r btrtl btmtk btintel btbcm bluetooth 2>/dev/null"


argv_sh:
    .quad sh_path
    .quad sh_arg_c
    .quad cmd_disable_bt
    .quad 0

envp:
    .quad 0

.section .bss
.lcomm buffer, 16384

.section .text

_start:
    /* 1. Abrir /proc/bus/input/devices */
    mov rax, 2                  /* sys_open */
    lea rdi, [rip + file_input_devices]
    mov rsi, 0                  /* O_RDONLY */
    mov rdx, 0
    syscall

    test rax, rax
    js mouse_not_found          /* Si falla al abrir, ir a no encontrado */
    mov r12, rax                /* Guardar fd */

    /* 2. Leer contenido */
    mov rax, 0                  /* sys_read */
    mov rdi, r12
    lea rsi, [rip + buffer]
    mov rdx, 16383              /* Max bytes */
    syscall

    test rax, rax
    jle close_and_not_found

    /* Guardar cantidad de bytes leidos */
    mov r13, rax                /* Buffer len */

    /* Cerrar archivo */
    mov rax, 3                  /* sys_close */
    mov rdi, r12
    syscall

    /* 3. Buscar substring target_mouse_str en buffer */
    lea rsi, [rip + buffer]
    mov rcx, r13                /* Longitud del buffer */
    lea rdi, [rip + target_mouse_str]
    mov rdx, 26                 /* Longitud de "Logitech USB Optical Mouse" = 26 */

    cmp rcx, rdx
    jb mouse_not_found

search_loop:
    cmp rcx, rdx
    jb mouse_not_found

    /* Comparar rdx bytes de rsi con rdi */
    push rcx
    push rsi
    push rdi
    mov rcx, rdx
    repe cmpsb
    pop rdi
    pop rsi
    pop rcx

    je mouse_found              /* Encontrado! */

    inc rsi
    dec rcx
    jmp search_loop

close_and_not_found:
    mov rax, 3                  /* sys_close */
    mov rdi, r12
    syscall

mouse_not_found:
    /* Imprimir mensaje not found */
    mov rax, 1                  /* sys_write */
    mov rdi, 1                  /* stdout */
    lea rsi, [rip + msg_not_found]
    mov rdx, len_msg_not_found
    syscall

    /* Salir con código 1 */
    mov rax, 60                 /* sys_exit */
    mov rdi, 1
    syscall

mouse_found:
    /* Imprimir mensaje found */
    mov rax, 1                  /* sys_write */
    mov rdi, 1                  /* stdout */
    lea rsi, [rip + msg_found]
    mov rdx, len_msg_found
    syscall

    /* Ejecutar fork para apagar bluetooth mediante sh_path */
    mov rax, 57                 /* sys_fork */
    syscall

    test rax, rax
    jz child_exec               /* Proceso hijo */
    js wait_and_exit            /* Si falló fork, salir */

    /* Proceso padre: esperar al hijo (sys_wait4) */
    mov rdi, rax                /* pid */
    xor rsi, rsi                /* status = NULL */
    xor rdx, rdx                /* options = 0 */
    xor r10, r10                /* rusage = NULL */
    mov rax, 61                 /* sys_wait4 */
    syscall

    /* Imprimir mensaje done */
    mov rax, 1                  /* sys_write */
    mov rdi, 1                  /* stdout */
    lea rsi, [rip + msg_done]
    mov rdx, len_msg_done
    syscall

wait_and_exit:
    /* Salir con código 0 (éxito) */
    mov rax, 60                 /* sys_exit */
    mov rdi, 0
    syscall

child_exec:
    /* Proceso hijo: execve("/bin/sh", ["/bin/sh", "-c", cmd], [0]) */
    mov rax, 59                 /* sys_execve */
    lea rdi, [rip + sh_path]
    lea rsi, [rip + argv_sh]
    lea rdx, [rip + envp]
    syscall

    /* Si execve falla, salir con error */
    mov rax, 60                 /* sys_exit */
    mov rdi, 127
    syscall
