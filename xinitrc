#!/bin/sh

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
xset r rate 150 110
feh --bg-scale $HOME/monoliths-hm/white-background.png &

if doas dmesg | grep -q ZenBook > /dev/null && uname -r | grep '5.10' > /dev/null; then
    doas modprobe -r snd_hda_intel; sleep 0.5 && doas modprobe snd_hda_intel; sleep 0.5 && amixer sset Master unmute; sleep 0.5 && amixer sset Master 50% &
else
    amixer sset Master 80%
fi

if grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
    doas /home/user/.type-to-move-cursor/setup_keymap.sh &
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

# Alerta de batería baja por la mañana (entre 8:55 AM y 9:55 AM) si no está conectado a la corrient
(
    # Esperar un poco a que el sistema de sonido esté listo
    sleep 4
    
    H=$(date +%-H)
    M=$(date +%-M)
    
    IN_RANGE=false
    if [ "$H" -eq 4 ]; then
        IN_RANGE=true
    elif [ "$H" -eq 5 ]; then
        IN_RANGE=true
    elif [ "$H" -eq 6 ]; then
        IN_RANGE=true
    elif [ "$H" -eq 7 ]; then
        IN_RANGE=true
    elif [ "$H" -eq 8 ]; then
        IN_RANGE=true
    elif [ "$H" -eq 9 ]; then
        IN_RANGE=true
    elif [ "$H" -eq 13 ]; then
	IN_RANGE=true
    elif [ "$H" -eq 18 ]; then
	IN_RANGE=true
    elif [ "$H" -eq 19 ]; then
	IN_RANGE=true
    elif [ "$H" -eq 20 ]; then
	IN_RANGE=true
    elif [ "$H" -eq 21 ]; then
	IN_RANGE=true
    elif [ "$H" -eq 22 ]; then
	IN_RANGE=true
    elif [ "$H" -eq 23 ]; then
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
        echo "$TEXT_TO_SPEAK" | /home/user/piper/piper --model /home/user/piper/es_MX-claude-high.onnx --output_file /tmp/power_alert.wav >/dev/null 2>&1
        /usr/bin/mpv --volume=80 --no-terminal --quiet /tmp/power_alert.wav >/dev/null 2>&1
    fi
) &

# 3. Calibración y apps de inicio
(sleep 0.5 && xcalib -i -a && touch /tmp/_xcalib_working) &

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# touchpad :
# Nombre exacto del dispositivo según xinput list
DEVICE="ELAN0791:00 04F3:30FD Touchpad"
if xinput list --name-only 2>/dev/null | grep -qxF "$DEVICE"; then
    # Obtenemos el estado actual del dispositivo (1 = encendido, 0 = apagado)
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
# 4. Lanzar aplicaciones de trabajo (con & para que no bloqueen el inicio)
NOGUI=false

pgrep xbindkeys | xargs kill
sleep 0.1
sleep 1.5 && xbindkeys &

# Ahorro de energía: si no está conectado a la corriente, ejecutar únicamente emacs y menú yad (con gestor de ventanas)
if [ -f /sys/class/power_supply/ADP1/online ] && [ "$(cat /sys/class/power_supply/ADP1/online)" = "0" ]; then
    if [ -f /usr/bin/emacs ]; then
	echo deep | doas tee /sys/power/mem_sleep &
	echo XHCI | doas tee /proc/acpi/wakeup &
	echo TXHC | doas tee /proc/acpi/wakeup &
	echo 1 | doas tee /sys/devices/system/cpu/intel_pstate/no_turbo &
	echo 1200000 | doas tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq &
        sleep 4 && emacs -mm --debug-init &
    fi
    if [ -f ~/monoliths-llm/a-llm-yad.sh ]; then
        while [ -f ~/monoliths-llm/a-llm-yad.sh ]; do dash ~/monoliths-llm/a-llm-yad.sh; sleep 1.5; done &
    fi
    exec openbox-session # & sleep 15s && doas pgrep X | xargs kill
fi

doas /home/user/monoliths-llm/gaming-mode.sh

if [ "$CURRENT_TTY" = "/dev/tty1" ]; then
    MIXEDCOLOR=''
    while [ -f /usr/bin/emacs ]; do sleep 4; emacs $MIXEDCOLOR -mm --debug-init; done &
    while [ -f ~/monoliths-llm/a-llm-yad.sh ]; do dash ~/monoliths-llm/a-llm-yad.sh; sleep 1.5; done &
    sleep 2
    while [ -f /usr/bin/google-chrome-stable ]; do
        if ! wmctrl -lx | awk '{print $3}' | grep -qi 'google-chrome'; then
            if doas dmesg | grep -q ZenBook > /dev/null; then
                google-chrome-stable &
            else
                google-chrome-stable --use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization &
            fi
            # google-chrome-stable https://web.whatsapp.com https://mail.google.com/mail/u/1 &
        fi
        sleep 4
    done &
    while ! pgrep scrcpy > /dev/null; do
	# 1. Validar si el celular está conectado físicamente al puerto USB
	if ! grep -qi 'android' /sys/bus/usb/devices/*/product 2>/dev/null; then
            echo '[USB] Esperando a que conectes el celular por USB...'
            sleep 0.5
            continue
	fi

	# 2. Si está conectado por USB, validar si ADB ya lo reconoce
	if adb devices | grep -v 'List of devices' | grep -q 'device'; then
            echo '[ADB] ¡Celular detectado y listo! Iniciando scrcpy...'
            LD_PRELOAD=/home/user/lib/sdl_cursor_hook.so scrcpy -d || adb kill-server && adb start-server
	else
            echo '[ADB] Celular detectado por USB, pero no por ADB. Reiniciando servidor...'
            adb kill-server && adb start-server && LD_PRELOAD=/home/user/lib/sdl_cursor_hook.so scrcpy -d || killall scrcpy
	fi
	sleep 0.5
    done &
    while [ -f '/opt/Antigravity-IDE/antigravity-ide' ]; do '/opt/Antigravity-IDE/antigravity-ide' ~/app-asociados-android; sleep 2; done &
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
    while [ -f /usr/bin/emacs ]; do sleep 4; emacs $MIXEDCOLOR -mm --debug-init; done &
    while [ -f ~/monoliths-llm/a-llm-yad.sh ]; do dash ~/monoliths-llm/a-llm-yad.sh; sleep 1.5; done &
fi

# exec start-lumina-desktop
if doas dmesg | grep -q ZenBook > /dev/null; then
    dash $HOME/monoliths-llm/enfriar-asus.sh &

    deskflow-server -c $HOME/deskflow.conf &
else
    # --- Configuración de variables ---
    if false; then
	TIEMPO_ESPERA=12

	dash $HOME/monoliths-llm/enfriar-hp.sh &

	# 1. Iniciar input-leap en segundo plano (como demonio con config)
	input-leap &

	# 2. Cuenta regresiva y xdotool en segundo plano para no bloquear Openbox
	(
            (
		i=$TIEMPO_ESPERA
		while [ "$i" -gt 0 ]; do
                    echo "Lanzando macro input-leap en: $i"
                    sleep 1
                    i=$((i - 1))
		done
            ) | osd_cat -p middle -A center -l 1 -c green -d 1

            # 3. Secuencia de pulsaciones y escritura
            xdotool key Alt+c
            sleep 0.5
            xdotool key Alt+c
            sleep 0.5
            xdotool key Alt+c
            sleep 0.5
            xdotool key Alt+c
	    sleep 0.5
            xdotool key Tab
	    sleep 0.5
	    xdotool type '192.168.0.162'
            sleep 0.5
            xdotool key Tab
            sleep 0.5
            xdotool key space
            sleep 0.5
            xdotool key Tab
            sleep 0.5
            xdotool key space
	    sleep 0.5 && wmctrl -i -r "$(wmctrl -l | awk '/InputLeap/ {print $1}')" -b add,hidden

	) &
    fi
fi

while [ -f /usr/bin/st ]; do  sleep 1; st; done &

if ! $NOGUI; then
    exec openbox-session # & sleep 15s && doas pgrep X | xargs kill
fi
