#!/bin/dash
for _osdbin in "$HOME/monoliths-hm/bin/personal_osdx" "$HOME/.local/bin/personal_osdx" "/usr/local/bin/personal_osdx"; do
    if [ -x "$_osdbin" ]; then
        "$_osdbin"
        # Mantener ejecución de hour_big_ascii
        bash "$HOME/monoliths-hm/hour_big_ascii.sh"
        exit 0
    fi
done

# 1. Obtener porcentaje y estado usando /sys/class/power_supply para mayor robustez
PERC=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 0)
ONLINE=$(cat /sys/class/power_supply/ADP1/online 2>/dev/null || echo 0)

# 2. Lógica de iconos con bloques
if [ "$ONLINE" -eq 1 ]; then
    BAT='⚡'
else
    # Lógica de bloques según porcentaje
    if [ "$PERC" -ge 85 ]; then
        BAT='[███]'
    elif [ "$PERC" -ge 40 ]; then
        BAT='[██░]'
    elif [ "$PERC" -ge 15 ]; then
        BAT='[█░░]'
    else
        BAT='[░░░]'
    fi
fi

# 3. Formatear la salida (12h con p.m./a.m. en español)
OPT="$PERC%"
TIME=$(LC_ALL=es_PE.utf8 TZ=America/Lima date +' %I:%M %p' | tr '[:upper:]' '[:lower:]' | sed 's/am/a.m./;s/pm/p.m./')

# Día y fecha en español, sin depender de que el locale español esté instalado.
case "$(TZ=America/Lima date +%u)" in
    1) WEEKDAY=LUNES ;; 2) WEEKDAY=MARTES ;; 3) WEEKDAY=MIERCOLES ;;
    4) WEEKDAY=JUEVES ;; 5) WEEKDAY=VIERNES ;; 6) WEEKDAY=SABADO ;;
    7) WEEKDAY=DOMINGO ;;
esac
case "$(TZ=America/Lima date +%m)" in
    01) MONTH=ENERO ;; 02) MONTH=FEBRERO ;; 03) MONTH=MARZO ;;
    04) MONTH=ABRIL ;; 05) MONTH=MAYO ;; 06) MONTH=JUNIO ;;
    07) MONTH=JULIO ;; 08) MONTH=AGOSTO ;; 09) MONTH=SEPTIEMBRE ;;
    10) MONTH=OCTUBRE ;; 11) MONTH=NOVIEMBRE ;; 12) MONTH=DICIEMBRE ;;
esac
DATE_LINE="$(TZ=America/Lima date +%-d) de $MONTH del $(TZ=America/Lima date +%Y)"

# 4. Lógica de visualización con xdotool en vez de wmctrl
# Si no hay batería o capacidad es 0, ocultar info de batería si se desea, 
# pero aquí mantengo el comportamiento original simplificado.

XEPHYR_ACTIVE=$(xdotool search --name "ctrl+shift releases" 2>/dev/null)
KEYBOARD_MODE=$(grep -q 'NOT MOUSE' "$HOME/.xbindkeysrc" 2>/dev/null && echo 'Keyboard quit Alt+2' || echo 'Mouse quit Alt+1')

printf "%s\n\n%s\n\n%s\n%s" \
       "$WEEKDAY" \
       "$DATE_LINE" \
       "$([ ! -f $HOME/.big_hour ] && echo -n $BAT $OPT $TIME)" \
       "$([ -n "$XEPHYR_ACTIVE" ] && echo 'Xephyr quit Ctrl+Shift' || echo "$KEYBOARD_MODE")" | \
    osd_cat --pos=top --align=right --offset=50 \
        --color="$([ -n "$XEPHYR_ACTIVE" ] && echo 'red' || (grep -q 'NOT MOUSE' "$HOME/.xbindkeysrc" 2>/dev/null && echo 'green' || echo 'orange'))" \
        --shadow=1 --delay=1 --lines=6

bash $HOME/monoliths-hm/hour_big_ascii.sh
