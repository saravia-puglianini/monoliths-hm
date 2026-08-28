#!/bin/sh

# Persistencia de aplicaciones principales.
# true: volver a abrir si se cierra. false: iniciar una sola vez.
emacs_persistent=false
chrome_persistent=true
RUN_EMACS_AT_START=false
RUN_CHROME_AT_START=true
export emacs_persistent chrome_persistent RUN_EMACS_AT_START RUN_CHROME_AT_START

# Sincronizar cookies Xauthority si se pasa por xinit -auth
if [ -n "$XAUTHORITY" ] && [ -f "$XAUTHORITY" ] && [ "$XAUTHORITY" != "$HOME/.Xauthority" ]; then
    xauth merge "$XAUTHORITY" 2>/dev/null
elif [ -n "$1" ] && [ -f "$1" ]; then
    xauth merge "$1" 2>/dev/null
fi

# Función para verificar si la máquina es ASUS
is_asus() {
    grep -qi 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null || \
    grep -qi 'zenbook' /sys/class/dmi/id/product_name 2>/dev/null
}

run_emacs_main() {
    emacs $MIXEDCOLOR -mm --debug-init \
        -l "$HOME/monoliths-hm/my.shell.el" \
        -l "$HOME/amd64gnu+linux/my.amd64gnu+linux.el" \
        --eval '(generate-hyperbole-scratch-menu)' \
        --eval '(generate-hyperbole-scratch-amd64gnu+linux-menu)'
}

start_emacs_managed() {
    [ "$RUN_EMACS_AT_START" = "true" ] || return 0
    [ -x /usr/bin/emacs ] || return 0
    if [ "$emacs_persistent" = "true" ]; then
        (
            while [ -x /usr/bin/emacs ]; do
                sleep 1
                run_emacs_main
            done
        ) &
    else
        (sleep 1; run_emacs_main) &
    fi
}

run_chrome_main() {
    # Chrome puede dejar estos enlaces tras un cierre brusco. Si no queda
    # ningún Chrome vivo, son huérfanos e impiden volver a abrir el perfil.
    if ! pgrep -x chrome >/dev/null 2>&1; then
        for singleton_path in \
            "$HOME/.config/google-chrome/SingletonLock" \
            "$HOME/.config/google-chrome/SingletonSocket" \
            "$HOME/.config/google-chrome/SingletonCookie"
        do
            [ -L "$singleton_path" ] && unlink "$singleton_path"
        done
    fi

    if is_asus; then
        google-chrome-stable --use-alsa \
            --disable-audio-service-sandbox \
            --alsa-input-device=entrada_buena_16k
    else
        google-chrome-stable --use-gl=angle --use-angle=gl \
            --ignore-gpu-blocklist --disable-vulkan \
            --disable-features=Vulkan --disable-gpu-rasterization
    fi
}

start_chrome_managed() {
    [ "$RUN_CHROME_AT_START" = "true" ] || return 0
    [ -x /usr/bin/google-chrome-stable ] || return 0
    if [ "$chrome_persistent" = "true" ]; then
        (
            while [ -x /usr/bin/google-chrome-stable ]; do
                # Si Chrome ya existe, esperar a que cierre. Esto evita llamar
                # al lanzador una vez por segundo mientras sigue abierto.
                if ! pgrep -x chrome >/dev/null 2>&1; then
                    run_chrome_main
                fi
                while pgrep -x chrome >/dev/null 2>&1; do
                    sleep 1
                done
                sleep 1
            done
        ) &
    else
        run_chrome_main &
    fi
}

# Load X resources
if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi

# Source .xprofile
if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

# Obtener secretos de ~/.obfuscate
get_secret() {
    [ -f "$HOME/.obfuscate" ] && sed -n "${1}p" "$HOME/.obfuscate"
}

setxkbmap latam
xsetroot -cursor_name left_ptr
xset r rate 120 160

# Cargar menú/acciones de Hyperbole mediante my.shell.el al inicio de X11
if [ -f "$HOME/monoliths-hm/my.shell.el" ]; then
    emacs --batch -l "$HOME/monoliths-hm/my.shell.el" &
fi

# Cargar menú/acciones de Hyperbole para amd64gnu+linux al inicio de X11
if [ -f "$HOME/amd64gnu+linux/my.amd64gnu+linux.el" ]; then
    emacs --batch -l "$HOME/amd64gnu+linux/my.amd64gnu+linux.el" \
          --eval '(generate-hyperbole-scratch-amd64gnu+linux-menu)' &
fi

(
    # Verificar si el mouse USB Logitech está conectado mediante el binario optimizador
    if [ -x "$HOME/monoliths-hm/bin/check_usb_mouse_bt_optimizer" ]; then
        "$HOME/monoliths-hm/bin/check_usb_mouse_bt_optimizer"
        USB_STATUS=$?
    else
        USB_STATUS=1
    fi

    # Si NO está conectado el mouse USB (código != 0), activar y conectar Bluetooth
    if [ "$USB_STATUS" -ne 0 ]; then
        MAC="13:08:AC:00:21:8A"

        if is_asus; then
            echo "--- Reiniciando módulos del kernel Bluetooth (ASUS) ---"
            doas modprobe -r btusb 2>/dev/null
            doas modprobe -r bluetooth 2>/dev/null
            sleep 1
            doas modprobe bluetooth 2>/dev/null
            doas modprobe btusb 2>/dev/null
            sleep 1

            echo "--- Desbloqueando e iniciando servicio Bluetooth ---"
            doas rfkill unblock bluetooth 2>/dev/null
            doas rfkill unblock all 2>/dev/null
            doas /etc/init.d/bluetooth restart 2>/dev/null
        else
            echo "--- Cargando módulos Bluetooth ---"
            doas modprobe bluetooth 2>/dev/null
            doas modprobe btusb 2>/dev/null

            echo "--- Desbloqueando e iniciando servicio Bluetooth ---"
            doas rfkill unblock bluetooth 2>/dev/null
            doas /etc/init.d/bluetooth start 2>/dev/null
        fi

        sleep 1
        doas hciconfig hci0 up 2>/dev/null
        doas hciconfig hci0 piscan 2>/dev/null

        sleep 1
        echo "--- Conectando al mouse TERAWARE5.0 ($MAC) ---"

        {
            echo "power on"
            sleep 2
            echo "agent on"
            echo "default-agent"
            sleep 1
            echo "scan on"
            sleep 2
            echo "pair $MAC"
            sleep 2
            echo "trust $MAC"
            sleep 1
            echo "connect $MAC"
            sleep 4
            echo "scan off"
            echo "quit"
        } | bluetoothctl

        echo ""
        echo "--- Estado final del dispositivo ---"
        echo "info $MAC" | bluetoothctl | grep -i -E "Name|Connected|Paired|Trusted"
    fi
) &

# Audio / ZenBook / Asus
if is_asus && uname -r | grep -q '5.10' 2>/dev/null; then
    bash $HOME/monoliths-llm/sof-snd-dsp.sh
    sleep 0.5 && amixer sset Master unmute; sleep 0.5 && amixer sset Master 100% &
else
    amixer sset Master 100%
fi

if is_asus; then
    [ -x /home/user/.type-to-move-cursor/setup_keymap.sh ] && doas /home/user/.type-to-move-cursor/setup_keymap.sh &
fi

# Registrar estado de batería inicial para bat.sh (cálculo de precisión)
(
    BAT_PATH="/sys/class/power_supply/BAT0"
    if [ ! -d "$BAT_PATH" ]; then
        BAT_PATH=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n 1)
    fi
    if [ -n "$BAT_PATH" ] && [ -f "$BAT_PATH/capacity" ]; then
        CAP=$(cat "$BAT_PATH/capacity")
        echo "$(date +%s) $CAP" > /tmp/bat.sh.log
    fi
) &

xhost +local:

# Alerta de batería baja por la mañana (entre 8:55 AM y 9:55 AM) si no está conectado a la corriente
(
    # Esperar un poco a que el sistema de sonido esté listo
    sleep 4
    
    H=$(date +%-H)
    M=$(date +%-M)
    
    IN_RANGE=false
    if [ "$H" -eq 8 ]; then
        IN_RANGE=true
    elif [ "$H" -eq 9 ]; then
        IN_RANGE=true
    fi
    
    if $IN_RANGE; then
        # Verificar estado de corriente y batería
        IS_ONLINE=0
        if [ -f /sys/class/power_supply/ADP1/online ]; then
            IS_ONLINE=$(cat /sys/class/power_supply/ADP1/online)
        fi

        if [ "$IS_ONLINE" = "1" ]; then
            if [ -f /sys/class/power_supply/BAT0/capacity ]; then
                CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
                BAT_STR="conectado a la corriente al $CAPACITY por ciento de batería cargada"
            else
                BAT_STR="conectado a la corriente"
            fi
        else
            # Obtener datos de batería
            if [ -f /sys/class/power_supply/BAT0/charge_now ] && [ -f /sys/class/power_supply/BAT0/current_now ]; then
                CHARGE=$(cat /sys/class/power_supply/BAT0/charge_now)
                CURRENT=$(cat /sys/class/power_supply/BAT0/current_now)
                if [ "$CURRENT" -gt 0 ]; then
                    MINUTES=$(( (CHARGE * 60) / CURRENT ))
                    HOURS=$(( MINUTES / 60 ))
                    MINS=$(( MINUTES % 60 ))
                    
                    # Formatear horas y minutos en español
                    if [ "$HOURS" -eq 1 ]; then
                        TXT_HOURS="1 hora"
                    else
                        TXT_HOURS="$HOURS horas"
                    fi
                    
                    if [ "$MINS" -eq 1 ]; then
                        TXT_MINUTES="1 minuto"
                    else
                        TXT_MINUTES="$MINS minutos"
                    fi
                    
                    BAT_STR="Tengo $TXT_HOURS y $TXT_MINUTES de tiempo de batería"
                else
                    BAT_STR="Tengo batería restante pero no puedo calcular el tiempo"
                fi
            else
                BAT_STR="Batería desconectada de la corriente"
            fi
        fi
        
        # Obtener fecha y hora en español
        DAY=$(date +%A)
        DAY="$(echo ${DAY} | awk '{print toupper(substr($0,1,1))tolower(substr($0,2))}')"
        MONTH=$(date +%B)
        MONTH="$(echo ${MONTH} | awk '{print toupper(substr($0,1,1))tolower(substr($0,2))}')"
        DOM=$(date +%-d)
        YEAR=$(date +%Y)
        
        # Determinar el período (mañana, tarde o noche)
        if [ "$H" -ge 18 ]; then
            PERIODO="de la noche"
        elif [ "$H" -ge 12 ]; then
            PERIODO="de la tarde"
        else
            PERIODO="de la mañana"
        fi

        # Formatear la hora
        HR=$(date +%-I)
        if [ "$M" -eq 0 ]; then
            MIN_STR="en punto"
        elif [ "$M" -eq 1 ]; then
            MIN_STR="y un minuto"
        else
            MIN_STR="y $M"
        fi
        
        if [ "$HR" -eq 1 ]; then
            ES_SON="Es la"
        else
            ES_SON="Son las"
        fi
        
        if [ "$M" -eq 0 ]; then
            TEXT_TO_SPEAK="$ES_SON $HR $PERIODO en punto, $DAY $DOM de $MONTH del $YEAR... $BAT_STR... Repito, $ES_SON $HR $PERIODO en punto"
        else
            TEXT_TO_SPEAK="$ES_SON $HR $MIN_STR $PERIODO, $DAY $DOM de $MONTH del $YEAR... $BAT_STR... Repito, $ES_SON $HR $MIN_STR $PERIODO"
        fi
        
        # Generar y reproducir audio con Piper (voz de Claude en español de México)
        if [ -x /home/user/piper/piper ] && [ -f /home/user/piper/es_MX-claude-high.onnx ]; then
            echo "$TEXT_TO_SPEAK" | /home/user/piper/piper --model /home/user/piper/es_MX-claude-high.onnx --output_file /tmp/power_alert.wav >/dev/null 2>&1
            /usr/bin/mpv --volume=80 --no-terminal --quiet /tmp/power_alert.wav >/dev/null 2>&1
        fi
    fi
) &

# 3. Calibración y apps de inicio
(sleep 0.5 && xcalib -i -a && touch /tmp/_xcalib_working) &

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# Touchpad :
DEVICE="ELAN0791:00 04F3:30FD Touchpad"
if xinput list --name-only 2>/dev/null | grep -qxF "$DEVICE"; then
    STATE=$(xinput list-props "$DEVICE" | grep "Device Enabled" | awk '{print $NF}')
    if [ "$STATE" = "1" ]; then
        xinput disable "$DEVICE"
        echo "Touchpad desactivado."
    elif [ "$STATE" = "0" ]; then
        xinput enable "$DEVICE"
        echo "Touchpad activado."
    fi
else
    echo "Dispositivo touchpad '$DEVICE' no encontrado en el sistema."
fi

CURRENT_TTY=$(tty)
NOGUI=false

pgrep xbindkeys | xargs kill 2>/dev/null
killall hotkey_listener_asm 2>/dev/null

# Iniciar el listener independientemente del estado/presencia de la batería.
# En un arranque en frío los dispositivos de entrada pueden aparecer después
# de X; si el listener termina por ello, reintentarlo en vez de perder hotkeys.
if [ -x "$HOME/monoliths-llm/hotkey_listener_asm" ]; then
    HOTKEY_LISTENER="$HOME/monoliths-llm/hotkey_listener_asm"
elif command -v hotkey_listener_asm >/dev/null 2>&1; then
    HOTKEY_LISTENER=$(command -v hotkey_listener_asm)
else
    HOTKEY_LISTENER=""
fi

if [ -n "$HOTKEY_LISTENER" ]; then
    (
        HOTKEY_LOG="$HOME/.hotkey_listener_asm.log"
        # Dar tiempo a udev/XInput en arranques sin batería conectada.
        sleep 1
        while [ -x "$HOTKEY_LISTENER" ]; do
            echo "=== Iniciando hotkey_listener_asm [$(date)] ===" >> "$HOTKEY_LOG"
            "$HOTKEY_LISTENER" >> "$HOTKEY_LOG" 2>&1
            EXIT_CODE=$?
            echo "=== hotkey_listener_asm terminó con código $EXIT_CODE [$(date)]; reintentando ===" >> "$HOTKEY_LOG"
            sleep 2
        done
    ) &
fi

unset HOTKEY_LISTENER

# Modo batería: mantener la configuración de persistencia de las aplicaciones.
if [ -f /sys/class/power_supply/ADP1/online ] && [ "$(cat /sys/class/power_supply/ADP1/online)" = "0" ]; then
    if [ -f /usr/bin/emacs ]; then
        echo deep | doas tee /sys/power/mem_sleep &
        echo XHCI | doas tee /proc/acpi/wakeup &
        echo TXHC | doas tee /proc/acpi/wakeup &
        echo 1 | doas tee /sys/devices/system/cpu/intel_pstate/no_turbo &
        echo 1200000 | doas tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq &
        start_emacs_managed
    fi

    # Esta rama termina con exec más abajo, por lo que Chrome debe iniciarse
    # aquí también; de otro modo chrome_persistent nunca llega a evaluarse.
    start_chrome_managed

    if [ "$CURRENT_TTY" = "/dev/tty1" ]; then
        (
            while true; do
                if ! pgrep -x scrcpy > /dev/null; then
                    if grep -qi 'android' /sys/bus/usb/devices/*/product 2>/dev/null; then
                        if adb devices | grep -v 'List of devices' | grep -q 'device$'; then
                            echo '[ADB] ¡Celular detectado y listo! Iniciando scrcpy...'
                            SCRCPY_KEYS="--keyboard=sdk"
                            if ! xinput list --pointer | grep -vE 'Virtual core pointer|XTEST' | grep -q 'id='; then
                                SCRCPY_KEYS="--keyboard=disabled"
                            fi
                            read SW SH <<EOF
$(xdotool getdisplaygeometry 2>/dev/null || echo "1920 1080")
EOF
                            DISPLAY=:0 SDL_HINT_GRAB_KEYBOARD=0 scrcpy -d --no-audio $SCRCPY_KEYS --shortcut-mod=lsuper --window-x=0 --window-y=0 --window-width=$SW --window-height=$SH --window-borderless --background-color=#ffffff
                        fi
                    fi
                fi
                sleep 2
            done
        ) &
    fi

    ASM_LOG="$HOME/.alt_tab_maximize_only-session-asm.log"
    echo "=== [BATTERY MODE] Iniciando alt_tab_maximize_emacs_asm [$(date)] ===" >> "$ASM_LOG"
    "$HOME/.local/bin/alt_tab_maximize_emacs_asm-session" >> "$ASM_LOG" 2>&1
    EXIT_CODE=$?
    echo "=== [BATTERY MODE] alt_tab_maximize_emacs_asm terminó/falló con código: $EXIT_CODE [$(date)] ===" >> "$ASM_LOG"

    echo "=== [BATTERY MODE] Levantando Window Manager Fallback [$(date)] ===" >> "$HOME/.alt_tab_maximize_emacs-buffer_only-session.log"
    if [ -f "$HOME/alt_tab_maximize_emacs-buffer_only/alt_tab_maximize_emacs-buffer_only-session" ]; then
        exec alt_tab_maximize_emacs-buffer_only-session >> "$HOME/.alt_tab_maximize_emacs-buffer_only-session.log" 2>&1
    else
        exec alt_tab_maximize_only-session >> "$HOME/.alt_tab_maximize_emacs-buffer_only-session.log" 2>&1
    fi
fi

if [ "$CURRENT_TTY" = "/dev/tty1" ]; then
    MIXEDCOLOR=''
    start_emacs_managed
    sleep 1
    start_chrome_managed
    (
        while true; do
            if ! pgrep -x scrcpy > /dev/null; then
                if grep -qi 'android' /sys/bus/usb/devices/*/product 2>/dev/null; then
                    if adb devices | grep -v 'List of devices' | grep -q 'device$'; then
                        echo '[ADB] ¡Celular detectado y listo! Iniciando scrcpy...'
                        SCRCPY_KEYS="--keyboard=sdk"
                        if ! xinput list --pointer | grep -vE 'Virtual core pointer|XTEST' | grep -q 'id='; then
                            SCRCPY_KEYS="--keyboard=disabled"
                        fi
                        read SW SH <<EOF
$(xdotool getdisplaygeometry 2>/dev/null || echo "1920 1080")
EOF
                        DISPLAY=:0 SDL_HINT_GRAB_KEYBOARD=0 scrcpy -d --no-audio $SCRCPY_KEYS --shortcut-mod=lsuper --window-x=0 --window-y=0 --window-width=$SW --window-height=$SH --window-borderless --background-color=#ffffff
                    fi
                fi
            fi
            sleep 2
        done
    ) &

elif [ "$CURRENT_TTY" = "/dev/tty2" ]; then
    sleep 1 && gromit-mpx &
    sleep 3 && chromium-native --app=https://gmail.com &
    sleep 3 && chromium-native --app="$(get_secret 5)" &
    sleep 3 && chromium-native --app=http://localhost:5173 &
elif [ "$CURRENT_TTY" = "/dev/tty3" ]; then
    sleep 1 && dash ~/literatura/message_img.sh 'Literatura desde cualquier idioma al español' &
    sleep 1 && cd ~/literatura; while [ -f literatura.sh ]; do dash literatura.sh; done &
    if [ ! -f /tmp/clock_is_run_already.pid ]; then
        while [ -f $HOME/monoliths-hm/optime.personal_osdx.sh ]; do
            if [ ! -f $HOME/.stop_personal_osdx ]; then
                touch /tmp/clock_is_run_already.pid
                dash $HOME/monoliths-hm/optime.personal_osdx.sh
            fi
            sleep 0.1
        done &
    fi
elif [ "$CURRENT_TTY" = "/dev/tty4" ]; then
    sleep 1 && dash ~/literatura/message_img.sh 'Literatura desde cualquier idioma al alemán' &
    sleep 1 && cd ~/Literatur; while true; do dash literatura.sh; done &
else
    start_emacs_managed
fi

# Asus ZenBook específicas (enfriamiento y deskflow)
if is_asus; then
    [ -f "$HOME/monoliths-llm/enfriar-asus.sh" ] && dash "$HOME/monoliths-llm/enfriar-asus.sh" &
    [ -f "$HOME/deskflow.conf" ] && deskflow-server -c "$HOME/deskflow.conf" &
fi

if ! $NOGUI; then
    ASM_LOG="$HOME/.alt_tab_maximize_only-session-asm.log"
    echo "=== Iniciando alt_tab_maximize_emacs_asm [$(date)] ===" >> "$ASM_LOG"
    
    "$HOME/.local/bin/alt_tab_maximize_emacs_asm-session" >> "$ASM_LOG" 2>&1
    EXIT_CODE=$?
    
    echo "=== alt_tab_maximize_emacs_asm terminó/falló con código: $EXIT_CODE [$(date)] ===" >> "$ASM_LOG"

    echo "=== Levantando Window Manager Fallback [$(date)] ===" >> "$HOME/.alt_tab_maximize_only-session.log"
    if [ -f "$HOME/alt_tab_maximize_emacs-buffer_only/alt_tab_maximize_emacs-buffer_only-session" ]; then
        exec alt_tab_maximize_emacs-buffer_only-session >> "$HOME/.alt_tab_maximize_emacs-buffer_only-session.log" 2>&1
    else
        exec alt_tab_maximize_only-session >> "$HOME/.alt_tab_maximize_only-session.log" 2>&1
    fi
fi
