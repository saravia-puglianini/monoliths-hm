#!/bin/dash

[ -z "$DISPLAY" ] && export DISPLAY=:0

QUIET=0
PARAM=""

for arg in "$@"; do
    if [ "$arg" = "-q" ]; then
        QUIET=1
    elif [ -z "$PARAM" ]; then
        PARAM="$arg"
    fi
done

Laptop=$(doas dmesg 2>/dev/null | grep -i -q 'HP' && echo HP || echo Asus)
LaptopMin=$(doas dmesg 2>/dev/null | grep -i -q 'HP' && echo hp || echo asus)
if [ -z "$PARAM" ]; then
    echo '=== Lista de Opciones ==='
    echo ''
    echo '1) Configurar_Resolucion - Configurar pantalla a 1024x576 a 60Hz'
    echo '2) Atajos_Teclado - Iniciar demonio de atajos personalizados (xbindkeys)'
    echo '3) Sincronizar_Hora - Ajustar reloj del sistema mediante red (ntpd)'
    echo '4) Reloj_Pantalla - Mostrar un reloj permanente en la esquina'
    echo '5) Esperar_Monitores - Pausar 5 seg si se conectaron monitores externos'
    echo '6) Arranque_Thinkpad - Ejecutar inicio automatico para Thinkpad (BT/Scripts)'
    echo '7) Auto_Teclado - Forzar Latam continuamente y apagar BloqMayus'
    echo '8) Resolucion_Consola - Reiniciar PC para arreglar el tamaño de letras en terminal (TTY)'
    echo '9) Calibrar_Trackball - Acelerar un poco mas la bola del TrackBall Mouse'
    echo '10) Monitor_Bateria - Seguimiento del nivel y tiempo de bateria en OSD'
    echo '11) Alternar_Aviso - Ocultar/Mostrar el aviso OSD de la hora permanentemente'
    echo '12) Control_Volumen - Abrir mezclador de sonido en terminal (Alsamixer)'
    echo '13) Silenciar_Pitos - Quitar sonido molesto de 'beep' del sistema (pcspkr)'
    echo '14) Rutina_Tracking_A - Trakear productivo mediante (xtimemon) de [10-13, 14-19]'
    echo '15) Rutina_Tracking_B - Trakear productivo mediante (xtimemon) de [10-12, 14-20]'
    echo '16) Rutina_Tracking_C - Trakear productivo mediante (xtimemon) de [09-13, 14-18]'
    echo '17) Rutina_Tracking_D - Trakear productivo mediante (xtimemon) de [09-12, 14-19]'
    echo '18) Rutina_Tracking_E - Trakear productivo mediante (xtimemon) de [09-12, 15-20]'
    echo '19) Modo_Noche_Monitor - Reducir todo el brillo a 0.2 para evitar fatiga visual'
    echo '20) Modo_Dia_Monitor - Subir iluminacion a 0.4 para habitaciones muy claras'
    echo '21) Audio_Por_HDMI - Enrutar sonido al televisor (HDMI) y abrir Firefox'
    echo '22) Prender_Bluetooth - Iniciar administradores y activar conectividad Bluetooth'
    echo '23) Apagar_Bluetooth - Detener administrador dbus y apagar consumo Bluetooth'
    echo '24) Camara_Espejo - Proyectar webcam frontal en esquina inferiar e imagen invertida'
    echo '25) Rutina_Tracking_F - Trakear extrema mañana usando xtimemon desde [07-09]'
    echo '26) Apagar_Luz_Wifi - Apagar el led molesto del dispositivo tplink usb'
    echo '27) Bloquear_Apagado - Evitar que la pantalla se vuelva negra tras inactividad'
    echo '28) Estudio_Nativo - Iniciar programa de literatura en idioma original'
    echo '29) Estudio_Traducido - Iniciar programa de literatura traducido al español'
    echo '30) Desactivar_BloqMayus - Inhabilitar la tecla de Mayusculas para comodidad al escribir'
    echo '31) Visitar_Mi_Guia - Visualizar atajos FVWM base leyendo el html en navegador'
    echo '32) Servicio_VPN - Comenzar conectividad virtual privada desde un buffer de emacs'
    echo '33) Velocidad_Experto - Hacer que la repeticion de teclas al presionar sea rapidisima'
    echo '34) Ocultar_Barra_Bat - Cerrar la barra inferior verde/roja de bateria'
    echo '35) Activar_BloqMayus - Restaurar funcionamiento normal de tecla Mayusculas'
    echo '36) Velocidad_Novato - Repetir mas lento cada letra en pulsacion sostenida'
    echo '37) Mostrar_Barra_Bat - Volver a iniciar la barra de nivel de bateria en pantalla'
    echo '38) Cerrar_Mi_Sesion - Matar aplicaciones abiertas y botar del servidor X a login manager'
    echo '39) Apagar_Equipo - Cerrar demonios y apagar el equipo por hardware permanentemente'
    echo '40) Configurar_Pantallas - Lanzar 'Arandr' para ajustar visualmente los monitores conectados'
    echo '41) Reiniciar_Sistema - Hacer un apagado controlado y encender inmediatamente el computador'
    echo '42) Layout_Latino_America - Cambiar mapeo del teclado a disposicion usual de America Latina'
    echo '43) Lanzar_Emacs_Normal - Iniciar instancia principal y completa del editor de texto Emacs'
    echo '44) Pronunciacion - Practicar lectura linea por linea con voz en Emacs (TTS)'
    echo '45) Layout_Aleman - Cambiar el layout del teclado a distribucion de Alemania (QWERTZ)'
    echo '46) Layout_Americano - Cambiar mapeo a distribucion de Ingles USA'
    echo '47) Layout_Espana - Cambiar del reclado a disposicion clasica de España'
    echo '48) Lanzar_Emacs_Desarrollo - Carga rapida de Emacs vacio con fondo negro visualmente'
    echo '49) Asistente_ChatGPT - Abrir aplicacion web oficial de chat bot inteligente en Chromium'
    echo '50) Respaldar_Archivos - Enviar modificacion locales a backup usando codigo git propio'
    echo '51) Abrir_YouTube - Lanzar pagina de YouTube usando el navegador integrado'
    echo '52) Grabar_Video_1m - Hacer un clip grabando mi escritorio solo durante un minuto continuo'
    echo '53) Grabar_Video_2m - Capturar de pantalla grabando por dos minutos seguido'
    echo '54) Grabar_Video_6m - Para grabar segmentos medios equivalentes a 6 minutos'
    echo '55) Grabar_Video_20m - Capturas grandes sin interrupcion en un periodo de viente min.'
    echo '56) Grabar_Video_30m - Extremo para capturar clase por el periodo de media hora'
    echo '57) Ver_Ultima_Grabacion - Reproducir automaticamente tu ultimo video grabado (MPV)'
    echo '58) Reloj_Segundos - Lanzar barra de progreso visual pidiendo cuenta en segundos primero'
    echo '59) Reloj_Minutos - Barra especifica pidiendo cuenta grande en formato de minutos directos'
    echo '60) Monitor_Colores_Invertidos - Invierte los colores de la pantalla para evitar forzar la vista'
    echo '61) Monitor_Colores_Monocromo - Pone la pantalla en monocromatico para evitar forzar la vista'
    echo '62) Quitar_Ruido_Ultima_Grabacion - Va a la ultima grabacion y con algunos clics quitas el ruido de la ultima grabacion'
    echo '63) Evitar_Incremento_Temperatura - Pone el CPU en modo controlado para evitar el incremento de temperatura'
    echo '64) Firefox_Ticket_Luis - Ingresa en firefox para registrar tickets de Luis a.'
    echo '65) Firefox_Looker_Jira - Ingresa en firefox para revisar el Looker y el Jira'
    echo '66) Estudio_Nativo_Silenciado - Alterna estudiar nativo entre en silencio y con sonido'
    echo '67) Apagar_Touchpad - Alterna entre apagar y encender Touchpad'
    echo '68) Xbindkeys_Touchpad_Switcher - Usar Alt+1/Alt+2 para controlar Touchpad via xbindkeys'
    echo '69) Touchpad_Fast - Duplicar la velocidad del touchpad'
    echo '70) Chromium_LuisAProfile - Profile para gestionar tickets de LuisA'
    echo '71) Chromium_GuiosepTProfile - Profile para gestionar tickets de GuiosepT'
    echo '72) Contar_Horas - Time counter'
    echo '73) GChrome_Profile_Ticket_ERC - Perfil para registrar ticket Evaluacion de riesgo crediticio'
    echo '74) GChrome_Profile_Tmp - Perfil clean tmp'
    echo "75) Emwm_$Laptop - Xephyr"
    echo "76) Emacs_$Laptop - emacs $Laptop"
    echo '77) Relax_Energy - Perfil powersave brutal'
    echo "78) Tmux_$Laptop - Tmux $Laptop"
    echo '79) Tmux_USA - Tmux USA'
    echo '80) Luz_Off_Pantalla - apagar la luz de la pantalla'
    echo '81) Max_Energy - Perfil non-powersave brutal'
    echo '811) Min_Energy_Remove_Modules - Perfil ultra powersave y apagado de módulos'
    echo '82) Ver_Log - Ver log del jira'
    echo '83) Google_Chrome_No_Inhibit - Mantener tty encendida'
    echo '84) Firefox_Tmp - Firefox tmp'
    echo '85) Bluetooth - Blueman Manager'
    echo '86) Loopback - Select Loopback audio'
    echo '87) JBL - audifinos'
    echo '88) Inhibir_Ambiente - Sin ruido'
    echo '89) chrome - con soporte loopback'
    echo '90) chrome_jbl - con soporte JBL'
    echo '91) Temporizador_Personalizado - Iniciar temporizador simple en pantalla (timer.sh)'
    echo '92) Ejercicios_Vocales - Lista interactiva de ejercicios vocales con checkbox'
    echo '531) 170MB-report - Ejecutar 170MB-report.sh'
    echo '532) 4k - Ejecutar 4k.sh'
    echo '533) JBL-Quantum350-wireless - Ejecutar JBL-Quantum350-wireless.sh'
    echo '534) Rocky-linux-8--gnumeric - Ejecutar Rocky-linux-8--gnumeric.sh'
    echo '535) Rocky-linux-8-abiword - Ejecutar Rocky-linux-8-abiword.sh'
    echo '536) _antigravity_ubuntu-05-chromium - Ejecutar _antigravity_ubuntu-05-chromium.sh'
    echo '537) _dialog - Ejecutar _dialog.sh'
    echo '538) _rec-to-certain-min - Ejecutar _rec-to-certain-min.sh'
    echo '539) a-llm-yad - Ejecutar a-llm-yad.sh'
    echo '540) auto - Ejecutar auto.sh'
    echo '541) bat - Ejecutar bat.sh'
    echo '542) change_brightness - Ejecutar change_brightness.sh'
    echo '543) clic_scrot - Ejecutar clic_scrot.sh'
    echo '544) debian-00-hacer-carpeta-de-trabajo - Ejecutar debian-00-hacer-carpeta-de-trabajo.sh'
    echo '545) debian-01-emacs-30 - Ejecutar debian-01-emacs-30.sh'
    echo '546) debian-02-bash - Ejecutar debian-02-bash.sh'
    echo '547) debian-03-blueman - Ejecutar debian-03-blueman.sh'
    echo '548) debian-04-bluez - Ejecutar debian-04-bluez.sh'
    echo '549) debian-05-chromium - Ejecutar debian-05-chromium.sh'
    echo '550) debian-06-coreutils - Ejecutar debian-06-coreutils.sh'
    echo '551) debian-07-dash - Ejecutar debian-07-dash.sh'
    echo '552) debian-08-dbus - Ejecutar debian-08-dbus.sh'
    echo '553) debian-09-grep - Ejecutar debian-09-grep.sh'
    echo '554) debian-10-openbox - Ejecutar debian-10-openbox.sh'
    echo '555) debian-11-pipewire - Ejecutar debian-11-pipewire.sh'
    echo '556) debian-12-procps - Ejecutar debian-12-procps.sh'
    echo '557) debian-13-wireplumber - Ejecutar debian-13-wireplumber.sh'
    echo '558) debian-14-xbindkeys - Ejecutar debian-14-xbindkeys.sh'
    echo '559) debian-15-xinit - Ejecutar debian-15-xinit.sh'
    echo '560) debian-16-xorg-server - Ejecutar debian-16-xorg-server.sh'
    echo '561) debian-17-openfortivpn - Ejecutar debian-17-openfortivpn.sh'
    echo '562) debian-17-pavucontrol - Ejecutar debian-17-pavucontrol.sh'
    echo '563) debian-18-htop - Ejecutar debian-18-htop.sh'
    echo '564) debian-18-network-manager - Ejecutar debian-18-network-manager.sh'
    echo '565) debian-19-conky-all - Ejecutar debian-19-conky-all.sh'
    echo '566) debian-19-gimp - Ejecutar debian-19-gimp.sh'
    echo '567) debian-20-gnome-shell - Ejecutar debian-20-gnome-shell.sh'
    echo '568) debian-20-linux-tools-common - Ejecutar debian-20-linux-tools-common.sh'
    echo '569) debian-21-linux-tools-generic - Ejecutar debian-21-linux-tools-generic.sh'
    echo '570) debian-21-thermald - Ejecutar debian-21-thermald.sh'
    echo '571) debian-22-acpid - Ejecutar debian-22-acpid.sh'
    echo '572) debian-23-avahi-daemon - Ejecutar debian-23-avahi-daemon.sh'
    echo '573) debian-24-gimp - Ejecutar debian-24-gimp.sh'
    echo '574) debian-25-htop - Ejecutar debian-25-htop.sh'
    echo '575) debian-26-openfortivpn - Ejecutar debian-26-openfortivpn.sh'
    echo '576) debian-27-st - Ejecutar debian-27-st.sh'
    echo '577) debian-run-all - Ejecutar debian-run-all.sh'
    echo '578) dev - Ejecutar dev.sh'
    echo '579) dialog - Ejecutar dialog.sh'
    echo '580) enfriar-asus - Ejecutar enfriar-asus.sh'
    echo '581) enfriar-hp - Ejecutar enfriar-hp.sh'
    echo '582) english-or-german-to-clipboard-on-spanish - Ejecutar english-or-german-to-clipboard-on-spanish.sh'
    echo '583) exercises_fast - Ejecutar exercises_fast.sh'
    echo '584) festival-de - Ejecutar festival-de.sh'
    echo '585) gaming-mode-check - Ejecutar gaming-mode-check.sh'
    echo '586) hibernacion_real - Ejecutar hibernacion_real.sh'
    echo '587) init - Ejecutar init.sh'
    echo '588) input-leap - Ejecutar input-leap.sh'
    echo '589) install-antigravity-portable - Ejecutar install-antigravity-portable.sh'
    echo '590) install-antigravity - Ejecutar install-antigravity.sh'
    echo '591) install-google-chrome-stable - Ejecutar install-google-chrome-stable.sh'
    echo '592) install-libatk-bridge - Ejecutar install-libatk-bridge.sh'
    echo '593) install-libatspi - Ejecutar install-libatspi.sh'
    echo '594) install-libdbus - Ejecutar install-libdbus.sh'
    echo '595) install-libsystemd - Ejecutar install-libsystemd.sh'
    echo '596) install-piper - Ejecutar install-piper.sh'
    echo '597) internet - Ejecutar internet.sh'
    echo '598) jira-reminder - Ejecutar jira-reminder.sh'
    echo '599) loopback-tampermonkey-button-server - Ejecutar loopback-tampermonkey-button-server.sh'
    echo '600) loopback-yad-normal - Ejecutar loopback-yad-normal.sh'
    echo '601) loopback-yad-server - Ejecutar loopback-yad-server.sh'
    echo '602) max_power - Ejecutar max_power.sh'
    echo '603) message_img - Ejecutar message_img.sh'
    echo '604) min_power - Ejecutar min_power.sh'
    echo '605) modo_blob - Ejecutar modo_blob.sh'
    echo '606) modo_optime - Ejecutar modo_optime.sh'
    echo '607) ocr_core - Ejecutar ocr_core.sh'
    echo '608) ocr_title_util - Ejecutar ocr_title_util.sh'
    echo '609) ocr_traducir_captura_HP - Ejecutar ocr_traducir_captura_HP.sh'
    echo '610) ocr_traducir_captura_HP_bk - Ejecutar ocr_traducir_captura_HP_bk.sh'
    echo '611) ocr_traducir_captura_HP_googletranslate - Ejecutar ocr_traducir_captura_HP_googletranslate.sh'
    echo '612) ops360-reminder - Ejecutar ops360-reminder.sh'
    echo '613) peliculas - Ejecutar peliculas.sh'
    echo '614) preparar_literatura - Ejecutar preparar_literatura.sh'
    echo '615) preparar_literatura_bible - Ejecutar preparar_literatura_bible.sh'
    echo '616) preparar_literatura_old - Ejecutar preparar_literatura_old.sh'
    echo '617) ram-report - Ejecutar ram-report.sh'
    echo '618) recscreencast - Ejecutar recscreencast.sh'
    echo '619) recscreencast_1m - Ejecutar recscreencast_1m.sh'
    echo '620) recscreencast_3m - Ejecutar recscreencast_3m.sh'
    echo '621) recscreencast_counting - Ejecutar recscreencast_counting.sh'
    echo '622) run-reminders - Ejecutar run-reminders.sh'
    echo '623) screenshot - Ejecutar screenshot.sh'
    echo '624) script-literatura-core - Ejecutar script-literatura-core.sh'
    echo '625) script-literatura-lang - Ejecutar script-literatura-lang.sh'
    echo '626) script-literatura-yad - Ejecutar script-literatura-yad.sh'
    echo '627) script-literatura - Ejecutar script-literatura.sh'
    echo '628) second-counter - Ejecutar second-counter.sh'
    echo '629) set-jbl-mic-100-loop - Ejecutar set-jbl-mic-100-loop.sh'
    echo '630) set-jbl-mic-100 - Ejecutar set-jbl-mic-100.sh'
    echo '631) share-the-last-video - Ejecutar share-the-last-video.sh'
    echo '632) simple_second_counter-N-yad - Ejecutar simple_second_counter-N-yad.sh'
    echo '633) simple_second_counter-N - Ejecutar simple_second_counter-N.sh'
    echo '634) simple_second_counter - Ejecutar simple_second_counter.sh'
    echo '635) simple_second_counter_xterm-N - Ejecutar simple_second_counter_xterm-N.sh'
    echo '636) simple_second_feh_counter - Ejecutar simple_second_feh_counter.sh'
    echo '637) sof-snd-dsp - Ejecutar sof-snd-dsp.sh'
    echo '638) start_reader_system - Ejecutar start_reader_system.sh'
    echo '639) suspender - Ejecutar suspender.sh'
    echo '640) suspender_real - Ejecutar suspender_real.sh'
    echo '641) training-on-left-seconds-a-range-of-N-minute - Ejecutar training-on-left-seconds-a-range-of-N-minute.sh'
    echo '642) tts_german - Ejecutar tts_german.sh'
    echo '643) tts_spanish - Ejecutar tts_spanish.sh'
    echo '644) ubuntu-00-hacer-carpeta-de-trabajo - Ejecutar ubuntu-00-hacer-carpeta-de-trabajo.sh'
    echo '645) ubuntu-01-emacs-29 - Ejecutar ubuntu-01-emacs-29.sh'
    echo '646) ubuntu-02-bash - Ejecutar ubuntu-02-bash.sh'
    echo '647) ubuntu-03-blueman - Ejecutar ubuntu-03-blueman.sh'
    echo '648) ubuntu-04-bluez - Ejecutar ubuntu-04-bluez.sh'
    echo '649) ubuntu-05-chromium - Ejecutar ubuntu-05-chromium.sh'
    echo '650) ubuntu-06-coreutils - Ejecutar ubuntu-06-coreutils.sh'
    echo '651) ubuntu-07-dash - Ejecutar ubuntu-07-dash.sh'
    echo '652) ubuntu-08-dbus - Ejecutar ubuntu-08-dbus.sh'
    echo '653) ubuntu-09-grep - Ejecutar ubuntu-09-grep.sh'
    echo '654) ubuntu-10-openbox - Ejecutar ubuntu-10-openbox.sh'
    echo '655) ubuntu-11-pulseaudio - Ejecutar ubuntu-11-pulseaudio.sh'
    echo '656) ubuntu-12-procps - Ejecutar ubuntu-12-procps.sh'
    echo '657) ubuntu-13-pavucontrol - Ejecutar ubuntu-13-pavucontrol.sh'
    echo '658) ubuntu-13-wireplumber - Ejecutar ubuntu-13-wireplumber.sh'
    echo '659) ubuntu-14-xbindkeys - Ejecutar ubuntu-14-xbindkeys.sh'
    echo '660) ubuntu-15-xinit - Ejecutar ubuntu-15-xinit.sh'
    echo '661) ubuntu-16-xorg-server - Ejecutar ubuntu-16-xorg-server.sh'
    echo '662) ubuntu-17-network-manager - Ejecutar ubuntu-17-network-manager.sh'
    echo '663) ubuntu-19-gnome-shell - Ejecutar ubuntu-19-gnome-shell.sh'
    echo '664) ubuntu-20-thermald - Ejecutar ubuntu-20-thermald.sh'
    echo '665) ubuntu-21-acpid - Ejecutar ubuntu-21-acpid.sh'
    echo '666) ubuntu-22-avahi-daemon - Ejecutar ubuntu-22-avahi-daemon.sh'
    echo '667) ubuntu-23-openfortivpn - Ejecutar ubuntu-23-openfortivpn.sh'
    echo '668) ubuntu-24-htop - Ejecutar ubuntu-24-htop.sh'
    echo '669) ubuntu-25-gimp - Ejecutar ubuntu-25-gimp.sh'
    echo '670) ubuntu-26-linux-tools-common - Ejecutar ubuntu-26-linux-tools-common.sh'
    echo '671) ubuntu-27-linux-tools-generic - Ejecutar ubuntu-27-linux-tools-generic.sh'
    echo '672) ubuntu-O3-firefox - Ejecutar ubuntu-O3-firefox.sh'
    echo '673) ubuntu-check-running - Ejecutar ubuntu-check-running.sh'
    echo '674) ubuntu-generate-missing - Ejecutar ubuntu-generate-missing.sh'
    echo '675) ubuntu-run-all - Ejecutar ubuntu-run-all.sh'
    echo '676) update-antigravity-portable - Ejecutar update-antigravity-portable.sh'
    echo '677) update-antigravity - Ejecutar update-antigravity.sh'
    echo '678) update-google-chrome-stable - Ejecutar update-google-chrome-stable.sh'
    echo '679) update-libatk-bridge - Ejecutar update-libatk-bridge.sh'
    echo '680) update-libatspi - Ejecutar update-libatspi.sh'
    echo '681) update-libdbus - Ejecutar update-libdbus.sh'
    echo '682) update-libsystemd - Ejecutar update-libsystemd.sh'
    echo '683) validate-freebsd-this-machine - Ejecutar validate-freebsd-this-machine.sh'
    echo '684) validate-openbsd-this-machine - Ejecutar validate-openbsd-this-machine.sh'
    echo '685) validate-plan9-this-machine - Ejecutar validate-plan9-this-machine.sh'
    echo '686) vociferate-core - Ejecutar vociferate-core.sh'
    echo '687) vociferate-pdf - Ejecutar vociferate-pdf.sh'
    echo '688) audio-sof - Out Laptop + In Mic Laptop (SOF Interno)'
    echo '689) audio-sof-filter - Out Laptop + In Mic Laptop con Filtro DSP'
    echo '690) audio-jbl - Out JBL + In Mic JBL Wireless'
    echo '691) audio-jbl-filter - Out JBL + In Mic JBL con Filtro DSP'
    echo '692) audio-jbl-loopback-jbl - Out JBL + In JBL + Loopback Mic JBL'
    echo '693) audio-jbl-filter-loopback-jbl - Out JBL + In JBL + Loopback Mic JBL con Filtro'
    echo '694) audio-jbl-loopback-sof - Out JBL + In JBL + Loopback Mic Laptop en JBL'
    echo '695) audio-jbl-filter-loopback-sof - Out JBL + In JBL + Loopback Mic Laptop Filtrado en JBL'
    echo '696) audio-qa-test - Ejecutar suite de pruebas QA Audio interactiva'
    echo '697) audio-stop / detener-todos-los-modulos-de-audio - Detener y descargar todos los módulos y procesos de audio'
    echo ''
fi

# --- Manejo de Parámetros ---
USER_INPUT=""

if [ -n "$PARAM" ]; then
    if echo "$PARAM" | grep -q '^[0-9]\+$'; then
        # Búsqueda por número directo dentro de los comandos 'echo'
        MATCH=$(grep "echo '$PARAM)" "$0" | head -n 1 | sed "s/.*echo '//; s/'.*//")
        if [ -n "$MATCH" ]; then
            if [ "$QUIET" -eq 1 ]; then
                echo "-> Ejecutando opción..."
                USER_INPUT="$PARAM"
            else
                printf "\nDesea seleccionar esta opcion? \n"
                printf "$MATCH [S/n] "
                read CONFIRM
                case "$CONFIRM" in
                    ""|[Ss]*)
                        [ ! -t 0 ] && echo "S"
                        echo "-> Ejecutando opción..."
                        USER_INPUT="$PARAM"
                        ;;
                    *) echo "Cancelado."; exit 0 ;;
                esac
            fi
        else
            echo "No se encontró la opción número $PARAM."
            exit 1
        fi
    else
        # Búsqueda por texto (insensible a mayúsculas) dentro de los echo
        # Filtramos para obtener solo el texto de la opción
        MATCHES=$(grep -i "echo '[0-9]\+) .*$PARAM" "$0" | sed "s/.*echo '//; s/'.*//")
        NUM_MATCHES=$(echo "$MATCHES" | grep -v "^$" | wc -l)

        if [ "$NUM_MATCHES" -eq 0 ]; then
            echo "No se encontró ninguna opción que coincida con '$PARAM'."
            exit 1
        elif [ "$NUM_MATCHES" -eq 1 ]; then
            if [ "$QUIET" -eq 1 ]; then
                echo "-> Ejecutando opción..."
                USER_INPUT=$(echo "$MATCHES" | cut -d')' -f1)
            else
                printf "\nDesea seleccionar esta opcion? \n"
                printf "$MATCHES [S/n] "
                read CONFIRM
                case "$CONFIRM" in
                    ""|[Ss]*)
                        [ ! -t 0 ] && echo "S"
                        echo "-> Ejecutando opción..."
                        USER_INPUT=$(echo "$MATCHES" | cut -d')' -f1)
                        ;;
                    *) echo "Cancelado."; exit 0 ;;
                esac
            fi
        else
            echo "Se encontraron varias opciones para '$PARAM':"
            echo "$MATCHES"
            printf "\nSe encontraron varias opciones. Ingresa el número para escoger (o Enter para cancelar): "
            read SELECTION
            if [ -z "$SELECTION" ]; then
                echo "Cancelado."
                exit 0
            fi
            # Validar que el número ingresado esté en el set de resultados encontrados
            if echo "$MATCHES" | grep -q "^$SELECTION)"; then
                USER_INPUT="$SELECTION"
            else
                echo "Error: La opción '$SELECTION' no es válida para la búsqueda '$PARAM'."
                exit 1
            fi
        fi
    fi
else
    # Comportamiento original si no hay parámetros
    printf 'Elige un número o escribe el comando: '
    read USER_INPUT
fi

case "$USER_INPUT" in
    1|Configurar_Resolucion)
        MODELINE_NAME=$(cvt 1024 576 60 | awk '/Modeline/ {print $2}')
        MODELINE_PARAMS=$(cvt 1024 576 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i " "; print ""}')
        xrandr --newmode $MODELINE_NAME $MODELINE_PARAMS
        xrandr --addmode eDP-1 $MODELINE_NAME
        xrandr --output eDP-1 --mode $MODELINE_NAME
        ;;
    2|Atajos_Teclado)
        xbindkeys
        ;;
    3|Sincronizar_Hora)
        doas ntpd
        ;;
    4|Reloj_Pantalla)
        if [ ! -f /tmp/clock_is_run_already.pid ]; then
            if [ -x "$HOME/monoliths-hm/bin/clock_osd" ]; then
                exec "$HOME/monoliths-hm/bin/clock_osd"
            else
                while true; do
                    if [ ! -f $HOME/.stop_personal_osdx ]; then
                        touch /tmp/clock_is_run_already.pid
                        dash $HOME/monoliths-hm/optime.personal_osdx.sh
                    fi
                    sleep 0.1
                done
            fi
        fi
        ;;
    5|Esperar_Monitores)
        if xrandr | grep -q ' DP-1 connected' ||
                xrandr | grep -q 'DP-2 connected' ||
                xrandr | grep -q 'HDMI-1 connected'; then
            sleep 5s
        fi
        ;;
    6|Arranque_Thinkpad)
        if doas dmesg | grep thinkpad > /dev/null; then
            sleep 2 && cd && bash literatura.sh && dash $HOME/monoliths-hm/autoinit.sh
            doas service dbus start; doas service bluetooth start
            ( sleep 3 && echo -e "power on\nexit" | bluetoothctl )
        fi
        ;;
    7|Auto_Teclado)
        echo 'latam' > /tmp/layout.my
        echo 'caps:none' > /tmp/caps_mode.my
        while true; do
            CAPS_MODE=$(cat /tmp/caps_mode.my)
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            setxkbmap -option "$CAPS_MODE"
            sleep 1
        done
        ;;
    8|Resolucion_Consola)
	echo 'Resolucion_Consola ... no works'
        # ( [ -f /etc/default/grub.normal ] || doas cp /etc/default/grub /etc/default/grub.normal ) && \
        #     cat /etc/default/grub | grep -q '800x600' && \
        #     ( doas cp /etc/default/grub.normal /etc/default/grub ) || \
        #         ( echo 'GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"' | doas tee -a /etc/default/grub && \
        #               echo 'GRUB_GFXMODE=800x600' | doas tee -a /etc/default/grub && \
        #               echo 'GRUB_GFXPAYLOAD_LINUX=keep' | doas tee -a /etc/default/grub ) && \
        #             ( doas grub-mkconfig -o /boot/grub/grub.cfg && doas reboot )
        ;;
    9|Calibrar_Trackball)
        if [ -x "$HOME/monoliths-hm/bin/trackball_calibrator" ]; then
            exec "$HOME/monoliths-hm/bin/trackball_calibrator"
        else
            while true; do
                ID=$(xinput list | grep 'SONiX Perixx Trackball Keyboard Mouse' | grep -o 'id=[0-9]*' | cut -d= -f2)
                PROPS=$(xinput list-props "$ID")
                echo "$PROPS" | grep -q 'libinput Accel Speed' && \
                    ( xinput --set-prop "$ID" 'libinput Accel Speed' -1.0; xinput --set-prop "$ID" 'libinput Accel Profile Enabled' 1 0 ) || \
                        ( xinput --set-prop "$ID" 'Device Accel Constant Deceleration' --type=float 4.0; \
                          xinput --set-prop "$ID" 'Device Accel Adaptive Deceleration' --type=float 4.0; \
                          xinput --set-prop "$ID" 'Device Accel Velocity Scaling' --type=float 4.0 )
                sleep 1
            done
        fi
        ;;
    10|Monitor_Bateria)
        if [ ! -f /tmp/clock_is_run_already.pid ]; then
            doas ntpd
            echo "$(date)" > $HOME/.start_at.log
            (
                while true; do
                    touch /tmp/clock_is_run_already.pid
                    echo "$(date)" > $HOME/.track_at.log
                    printf "B.T. \n\n%s\n%s" "$(date +'%T')" "$(wmctrl -l | grep -q 'ctrl+shift releases' && echo 'Xephyr quit Ctrl+Shift' || ( grep -q 'NOT MOUSE' $HOME/.xbindkeysrc && echo 'Keyboard quit Alt+2' || echo 'Mouse quit Alt+1' ))" | osd_cat --pos=top --align=right --offset=50 --color=green --shadow=1 --delay=1 --lines=4 --font='-misc-fixed-*-*-*-*-30-*-*-*-*-*-*-*'
                    sleep 0.5
                done
            )
        fi
        ;;
    11|Alternar_Aviso)
        [ -f "$HOME/.stop_personal_osdx" ] && rm "$HOME/.stop_personal_osdx" || touch "$HOME/.stop_personal_osdx"
        ;;
    12|Control_Volumen)
	export DISPLAY=:0
        xterm -e 'alsamixer'
        ;;
    13|Silenciar_Pitos)
        doas rmmod pcspkr
        ;;
    14|Rutina_Tracking_A)
        HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 13 ]; then ( xtimemon -S 10:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
        ;;
    15|Rutina_Tracking_B)
        HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 12 ]; then ( xtimemon -S 10:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 20 ]; then ( xtimemon -S 14:00 -E 20:00 -p top ); fi
        ;;
    16|Rutina_Tracking_C)
        HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 13 ]; then ( xtimemon -S 09:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 18 ]; then ( xtimemon -S 14:00 -E 18:00 -p top ); fi
        ;;
    17|Rutina_Tracking_D)
        HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
        ;;
    18|Rutina_Tracking_E)
        HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 15 -a $HOUR -lt 20 ]; then ( xtimemon -S 15:00 -E 20:00 -p top ); fi
        ;;
    19|Modo_Noche_Monitor)
        for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.2; done
        ;;
    20|Modo_Dia_Monitor)
        for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.4; done
        ;;
    21|Audio_Por_HDMI)
        doas service tor start && doas service sndiod start && sleep 1 && sndiod -f rsnd/0,3 && firefox > /dev/null 2>&1
        ;;
    22|Prender_Bluetooth)
        doas service dbus start; doas service bluetooth start
        ;;
    23|Apagar_Bluetooth)
        doas service dbus stop; doas service bluetooth stop
        ;;
    24|Camara_Espejo)
        ffplay -fflags nobuffer -flags low_delay -framedrop -vf 'crop=250:530:(iw-250)/2:(ih-530)/2,hflip' /dev/video0
        ;;
    25|Rutina_Tracking_F)
        HOUR=$(date +%H); if [ $HOUR -ge 7 -a $HOUR -lt 10 ]; then ( xtimemon -S 7:20 -E 9:20 -p top ); fi
        ;;
    26|Apagar_Luz_Wifi)
        ( echo 0 | doas tee /sys/class/leds/ath9k_htc-phy1/brightness || echo 0 | doas tee /sys/class/leds/ath9k_htc-phy0/brightness )
        ;;
    27|Bloquear_Apagado)
        xset s off && xset s noblank && xset -dpms
        ;;
    28|Estudio_Nativo)
        cd $HOME/literatura && dash literatura.sh
        ;;
    29|Estudio_Traducido)
        cd $HOME/literatura-to-es && dash literatura.sh
        ;;
    30|Desactivar_BloqMayus)
        setxkbmap -option caps:none
        ;;
    31|Visitar_Mi_Guia)
        bash /usr/share/fvwm3/default-config/c || chromium
        ;;
    32|Servicio_VPN)
        emacs --eval='(ofv)'
        ;;
    33|Velocidad_Experto)
        while true; do
            xset r rate 150 110
            sleep 1
        done
        ;;
    34|Ocultar_Barra_Bat)
        killall xbattmon
        ;;
    35|Activar_BloqMayus)
        setxkbmap -option
        ;;
    36|Velocidad_Novato)
        while true; do
            xset r rate 140 60
            sleep 1
        done
        ;;
    37|Mostrar_Barra_Bat)
        xbattmon
        ;;
    38|Cerrar_Mi_Sesion)
        doas killall X
        ;;
    39|Apagar_Equipo)
        doas poweroff
        ;;
    40|Configurar_Pantallas)
        arandr
        ;;
    41|Reiniciar_Sistema)
        doas reboot
        ;;
    42|Layout_Latino_America)
        echo 'latam' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    43|Lanzar_Emacs_Normal)
        emacs -mm
        ;;
    44|Pronunciacion)
        emacs -mm -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)'
        if ! doas dmesg | grep thinkpad > /dev/null; then
            audacity
        fi
        ;;
    45|Layout_Aleman)
        echo 'de' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    46|Layout_Americano)
        echo 'us' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    47|Layout_Espana)
        echo 'es' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    48|Lanzar_Emacs_Desarrollo)
        emacs -mm -fg white -bg black -q -Q
        ;;
    49|Asistente_ChatGPT)
        chromium --app='https://chatgpt.com'
        ;;
    50|Respaldar_Archivos)
        cd && dash saravia
        ;;
    51|Abrir_YouTube)
        chromium --app='https://youtube.com'
        ;;
    52|Grabar_Video_1m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 1
        end=$((SECONDS + 1*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    53|Grabar_Video_2m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 2
        end=$((SECONDS + 2*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    54|Grabar_Video_6m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 6
        end=$((SECONDS + 6*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    55|Grabar_Video_20m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 20
        end=$((SECONDS + 20*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    56|Grabar_Video_30m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 30
        end=$((SECONDS + 30*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    57|Ver_Ultima_Grabacion)
        latest_video=$(ls -t "$HOME"/simplescreenrecorder-*.mkv 2>/dev/null | head -1)
        mpv "$latest_video"
        ;;
    58|Reloj_Segundos)
        dash $HOME/monoliths-llm/simple_second_counter_xterm-N-yad.sh
        ;;
    59|Reloj_Minutos)
        dash $HOME/monoliths-llm/special_minute_counter_xtimemon-N-yad.sh
        ;;
    60|Monitor_Colores_Invertidos)
        if [ -f /tmp/_xcalib_working ]; then
            rm /tmp/_xcalib_working
        fi
        sleep 0.5 && xcalib -i -a
	;;			   
    61|Monitor_Colores_Monocromo)
        if pgrep picom > /dev/null; then
            killall picom
        else
            sleep 0.9 && picom --backend glx --no-fading-openclose --inactive-opacity=1.0 --active-opacity=1.0 --frame-opacity=1.0 --no-use-damage --window-shader-fg $HOME/monoliths-llm/blackandwhite.frag
        fi
	;;
    62|Quitar_Ruido_Ultima_Grabacion)
	cd $HOME
        latest_video=$(ls -t simplescreenrecorder-*.mkv 2>/dev/null | head -n 1)
        if [ -n "$latest_video" ]; then
            dash $HOME/quitarRuidoPandero "$latest_video"
        fi
	;;
    63|Evitar_Incremento_Temperatura)
	dash "${HOME}/monoliths-llm/enfriar-${LaptopMin}.sh"
	;;
    64|Firefox_Ticket_Luis)
	mkdir -p $HOME/.firefox-jira-ticket-frontalunificado-profile && firefox --profile $HOME/.firefox-jira-ticket-frontalunificado-profile
	;;
    65|Firefox_Looker_Jira)
	mkdir -p $HOME/.firefox-looker-jira-profile && firefox --profile $HOME/.firefox-looker-jira-profile
	;;
    66|Estudio_Nativo_Silenciado)
	if cat  | grep "#  MUTE=''" > /dev/null; then
	    sed -i "s/  MUTE=''/#  MUTE=''/" $HOME/Literatur/script-literatura.sh
	    sed -i "s/  MUTE=''/#  MUTE=''/" $HOME/literatura/script-literatura.sh
	else
	    sed -i "s/#  MUTE=''/  MUTE=''/" $HOME/Literatur/script-literatura.sh
	    sed -i "s/#  MUTE=''/  MUTE=''/" $HOME/literatura/script-literatura.sh
	fi
	;;
    67|Apagar_Touchpad)
	# Nombre exacto del dispositivo según xinput list
	DEVICE="ELAN0791:00 04F3:30FD Touchpad"

	# Obtenemos el estado actual del dispositivo (1 = encendido, 0 = apagado)
	# Usamos awk para extraer el último valor de la línea "Device Enabled"
	STATE=$(xinput list-props "$DEVICE" | grep "Device Enabled" | awk '{print $NF}')

	# Evaluamos el estado y lo cambiamos
	if [ "$STATE" = "1" ]; then
	    xinput disable "$DEVICE"
	    echo "Touchpad desactivado."
	elif [ "$STATE" = "0" ]; then
	    xinput enable "$DEVICE"
	    echo "Touchpad activado."
	else
	    echo "Error: No se pudo determinar el estado actual del touchpad."
	    exit 1
	fi
	;;
    68|Xbindkeys_Touchpad_Switcher)
	# Buscar si existe el respaldo temporal
	TEMP_BACKUP=$(ls $HOME/.xbindkeys.*.tmp 2>/dev/null | head -n 1)

	if [ -n "$TEMP_BACKUP" ]; then
	    # Modo Restauración: Regresar al original
	    rm -f "$HOME/.xbindkeysrc"
	    mv "$TEMP_BACKUP" "$HOME/.xbindkeysrc"
	    killall xbindkeys 2>/dev/null
	    xbindkeys
	    echo "Configuración original de xbindkeys restaurada."
	else
	    # Modo Activación: Crear configuración temporal
	    TIMESTAMP=$(date +%s)
	    if [ -f "$HOME/.xbindkeysrc" ]; then
		mv "$HOME/.xbindkeysrc" "$HOME/.xbindkeys.$TIMESTAMP.tmp"
		echo "Respaldo creado: .xbindkeys.$TIMESTAMP.tmp"
	    fi

	    # Crear nueva config con Alt+1 (OFF) y Alt+2 (ON)
	    cat <<EOF > "$HOME/.xbindkeysrc"
# Touchpad Switcher Mode
"xinput disable 'ELAN0791:00 04F3:30FD Touchpad'"
  Alt+1

"xinput enable 'ELAN0791:00 04F3:30FD Touchpad'"
  Alt+2
EOF
	    killall xbindkeys 2>/dev/null
	    xbindkeys -f "$HOME/.xbindkeys"
	    echo "Modo Touchpad Switcher activado: Alt+1 (Apagar), Alt+2 (Encender)."
	fi
	;;
    69|Touchpad_Fast)
	DEVICE="ELAN0791:00 04F3:30FD Touchpad"
	# Usamos las propiedades de Synaptics detectadas (MinSpeed, MaxSpeed, AccelFactor)
	# Valores originales: 1.0 1.75 0.05 -> Duplicamos para mas rapidez
	xinput --set-prop "$DEVICE" "Synaptics Move Speed" 2.0 4.0 0.15 0.0
	echo "Velocidad del touchpad aumentada (Synaptics)."
	;;
    70|Chromium_LuisAProfile)
	HP_PARAM=''
	ASUS_PARAM=''
	if ! grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	    HP_PARAM='--use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization'
	else
	    ASUS_PARAM=''
	fi
        mkdir -p $HOME/.chromium_luis_a_profile_tikets && setsid google-chrome-stable $HP_PARAM --user-data-dir=$HOME/.chromium_luis_a_profile_tikets > /dev/null 2>&1 ;
	;;
    71|Chromium_GuiosepTProfile)
	HP_PARAM=''
	ASUS_PARAM=''
	if ! grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	    HP_PARAM='--use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization'
	else
	    ASUS_PARAM=''
	fi
        mkdir -p $HOME/.chromium_guiosep_profile_tikets && setsid google-chrome-stable $HP_PARAM --user-data-dir=$HOME/.chromium_guiosep_profile_tikets > /dev/null 2>&1 ;
	;;
    72|Contar_Horas)
        if [ ! -f /tmp/Contar_Horas_counter_is_run_already.pid ]; then
            if [ -x "$HOME/monoliths-hm/bin/hour_counter_osd" ]; then
                exec "$HOME/monoliths-hm/bin/hour_counter_osd"
            else
                while true; do
                    if [ ! -f $HOME/.stop_personal_osdx ]; then
                        touch /tmp/Contar_Horas_counter_is_run_already.pid
                        bash $HOME/monoliths-hm/hour_big_count_ascii.sh
                    fi
                    sleep 0.1
                done
            fi
        fi
        ;;
    73|GChrome_Profile_Ticket_ERC)
	HP_PARAM=''
	ASUS_PARAM=''
	if ! grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	    HP_PARAM='--use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization'
	else
	    ASUS_PARAM='--use-alsa --disable-audio-service-sandbox --alsa-input-device=entrada_buena_jbl'
	fi
	folder='chromium-new-profile-ticket-erc'; mkdir -p "$HOME/.$folder" && setsid google-chrome-stable $HP_PARAM $ASUS_PARAM --user-data-dir="$HOME/.$folder" > /dev/null 2>&1 ;
	;;
    74|GChrome_Profile_Tmp)
	HP_PARAM=''
	ASUS_PARAM=''
	if ! grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	    HP_PARAM='--use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization'
	else
	    ASUS_PARAM='--use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop'
	fi
	ln -svf $HOME/monoliths-hm/asoundrc.conf ~/.asoundrc && tmpfolder="/tmp/chromium-new-profile-tmp-$(date +%Y%M%d%M%S)"; mkdir -p "$tmpfolder"; setsid google-chrome-stable $HP_PARAM $ASUS_PARAM --user-data-dir="$tmpfolder" > /dev/null 2>&1 ;
	;;
    75|Emwm_$Laptop)
	# 1. Asegurar que Xephyr sabe dónde abrirse localmente (tu pantalla principal)
	export DISPLAY=:0

	# 2. Limpiar procesos anteriores
	killall Xephyr 2>/dev/null

	# 3. Iniciar Xephyr en el display :9 (ahora sí se abrirá encima de tu display :0)
	Xephyr :9 -br -ac -noreset -screen 1280x700 ;

	# 4. Esperar a que inicialice
	sleep 1

	# 5. FORZAR a todo lo que viene abajo (SSH) a usar el nuevo display de Xephyr
	export DISPLAY=:9
	xhost +SI:localuser:$(whoami) >/dev/null 2>&1

	# 5. Conectar por SSH ejecutando tu secuencia de arranque
	sshpass -f $HOME/.pass ssh \
	    -o ControlMaster=no \
	    -o ControlPath=none \
	    -o StrictHostKeyChecking=no \
	    -o UserKnownHostsFile=/dev/null \
	    -o PubkeyAuthentication=no \
	    -o PasswordAuthentication=yes \
	    -Y \
	    -R 6009:localhost:6009 \
	    -S none $(cat $HOME/.asdf)@$(cat $HOME/.fdsa) '
	    sleep 0.4 && setxkbmap latam &
	    sleep 0.5 && emacs -mm &
	    #sleep 0.6 && xbindkeys &
	    #sleep 0.7 && xdotool click 3 &
	    #sleep 0.8 && xset r rate 150 110 &
	    #sleep 0.9 && feh --bg-scale $HOME/monoliths-hm/white-background.png &
	    exec openbox-session
	    # exec emwm
	    # exec gnome-session
	    '
	;;
    76|Emacs_$Laptop)
	read -r SSH_USER < "$HOME/.asdf"
	read -r SSH_HOST < "$HOME/.fdsa"

	ssh \
	    -o ControlMaster=no \
	    -o ControlPath=none \
	    -Y \
	    "$SSH_USER@$SSH_HOST" \
	    emacs
	;;    
    77|Relax_Energy)
	echo deep | doas tee /sys/power/mem_sleep
	echo XHCI | doas tee /proc/acpi/wakeup
	echo TXHC | doas tee /proc/acpi/wakeup
	echo 1 | doas tee /sys/devices/system/cpu/intel_pstate/no_turbo
	echo 1200000 | doas tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
	;;
    78|Tmux_$Laptop)
	read -r SSH_USER < "$HOME/.asdf"
	read -r SSH_HOST < "$HOME/.fdsa"
	st -t "Tmux_${Laptop}" -e sh -c "ssh -tt ${SSH_USER}@${SSH_HOST} 'export TERM=xterm-256color; tmux attach || tmux'"
	;;
    79|Tmux_USA)
	pkill st
	dash "$HOME/$(cat $HOME/.personal)/USA.sh"
  	;;
    80|Luz_Off_Pantalla)
	( sleep 3 && xset dpms force off ) ;
	;;
    81|Max_Energy)
	doas $HOME/monoliths-llm/gaming-mode.sh
	;;
    811|Min_Energy_Remove_Modules|min-energy-remove-modules)
	if [ -f "$HOME/monoliths-llm/min-energy-remove-modules.sh" ]; then
	    doas "$HOME/monoliths-llm/min-energy-remove-modules.sh"
	else
	    doas "$HOME/monoliths-hm/min-energy-remove-modules.sh"
	fi
	;;
    82|Ver_Log)
	bash $HOME/monoliths-llm/ver-horas.sh &
	;;
    83|Google_Chrome_No_Inhibit)
	export DISPLAY=:0
	HP_PARAM=''
	if ! grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	    HP_PARAM='--use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization'
	fi
	systemd-inhibit --why="Necesito mantener la conexión en TTY" google-chrome $HP_PARAM
	;;
    84|Firefox_Tmp)
	export DISPLAY=:0
	mkdir -p $HOME/.firefox-new-profile-$(date +%s) && setsid firefox --profile $HOME/.firefox-new-profile-$(date +%s) >/dev/null 2>&1 &
	;;
    85|Bluetooth)
	export DISPLAY=:0
        setsid blueman-applet > /dev/null 2>&1 ; sleep 1 && setsid blueman-manager > /dev/null 2>&1 ;
	;;
    86|Loopback)
	export DISPLAY=:0
	setsid pavucontrol >/dev/null ; bash $HOME/monoliths-llm/loopback-yad.sh ;
	;;
    87|JBL)
	bash $HOME/monoliths-llm/JBL-FILTER-Quantum350-wireless.sh
	;;
    88|Inhibir_Ambiente)
	bash $HOME/monoliths-llm/inhibir-ambiente.sh
	;;
    89|chrome)
	export DISPLAY=:0
	HP_PARAM=''
	ASUS_PARAM=''
	if ! grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	    HP_PARAM='--use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization'
	else
	    ASUS_PARAM='--use-alsa --disable-audio-service-sandbox --alsa-input-device=entrada_buena'
	fi
	ln -svf $HOME/monoliths-hm/asoundrc.conf ~/.asoundrc && setsid google-chrome-stable $HP_PARAM $ASUS_PARAM
	;;
    90|chrome_jbl)
	export DISPLAY=:0
	HP_PARAM=''
	ASUS_PARAM=''
	if ! grep -q -i 'asus' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	    HP_PARAM='--use-gl=angle --use-angle=gl --ignore-gpu-blocklist --disable-vulkan --disable-features=Vulkan --disable-gpu-rasterization'
	else
	    ASUS_PARAM='--use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop'
	fi
	ln -svf $HOME/monoliths-hm/asoundrc.conf ~/.asoundrc && setsid google-chrome-stable $HP_PARAM $ASUS_PARAM
	;;
    91|Temporizador_Personalizado)
	printf "Ingrese la cantidad de minutos: "
	read MINUTOS
	if [ -n "$MINUTOS" ]; then
	    if [ -x "$HOME/monoliths-hm/bin/simple_timer" ]; then
	        SEGUNDOS=$((MINUTOS * 60))
	        "$HOME/monoliths-hm/bin/simple_timer" "$SEGUNDOS"
	    else
	        dash $HOME/monoliths-llm/timer.sh "$MINUTOS"
	    fi
	fi
	;;
    92|Ejercicios_Vocales)
	dash $HOME/monoliths-llm/exercises_nice.sh
	;;
    531|170MB-report)
	dash $HOME/monoliths-llm/170MB-report.sh
	;;
    532|4k)
	dash $HOME/monoliths-llm/4k.sh
	;;
    533|JBL-Quantum350-wireless)
	dash $HOME/monoliths-llm/JBL-Quantum350-wireless.sh
	;;
    534|Rocky-linux-8--gnumeric)
	dash $HOME/monoliths-llm/Rocky-linux-8--gnumeric.sh
	;;
    535|Rocky-linux-8-abiword)
	dash $HOME/monoliths-llm/Rocky-linux-8-abiword.sh
	;;
    536|_antigravity_ubuntu-05-chromium)
	dash $HOME/monoliths-llm/_antigravity_ubuntu-05-chromium.sh
	;;
    537|_dialog)
	dash $HOME/monoliths-llm/_dialog.sh
	;;
    538|_rec-to-certain-min)
	dash $HOME/monoliths-llm/_rec-to-certain-min.sh
	;;
    539|a-llm-yad)
	dash $HOME/monoliths-llm/a-llm-yad.sh
	;;
    540|auto)
	dash $HOME/monoliths-llm/auto.sh
	;;
    541|bat)
	dash $HOME/monoliths-llm/bat.sh
	;;
    542|change_brightness)
	dash $HOME/monoliths-llm/change_brightness.sh
	;;
    543|clic_scrot)
	dash $HOME/monoliths-llm/clic_scrot.sh
	;;
    544|debian-00-hacer-carpeta-de-trabajo)
	dash $HOME/monoliths-llm/debian-00-hacer-carpeta-de-trabajo.sh
	;;
    545|debian-01-emacs-30)
	dash $HOME/monoliths-llm/debian-01-emacs-30.sh
	;;
    546|debian-02-bash)
	dash $HOME/monoliths-llm/debian-02-bash.sh
	;;
    547|debian-03-blueman)
	dash $HOME/monoliths-llm/debian-03-blueman.sh
	;;
    548|debian-04-bluez)
	dash $HOME/monoliths-llm/debian-04-bluez.sh
	;;
    549|debian-05-chromium)
	dash $HOME/monoliths-llm/debian-05-chromium.sh
	;;
    550|debian-06-coreutils)
	dash $HOME/monoliths-llm/debian-06-coreutils.sh
	;;
    551|debian-07-dash)
	dash $HOME/monoliths-llm/debian-07-dash.sh
	;;
    552|debian-08-dbus)
	dash $HOME/monoliths-llm/debian-08-dbus.sh
	;;
    553|debian-09-grep)
	dash $HOME/monoliths-llm/debian-09-grep.sh
	;;
    554|debian-10-openbox)
	dash $HOME/monoliths-llm/debian-10-openbox.sh
	;;
    555|debian-11-pipewire)
	dash $HOME/monoliths-llm/debian-11-pipewire.sh
	;;
    556|debian-12-procps)
	dash $HOME/monoliths-llm/debian-12-procps.sh
	;;
    557|debian-13-wireplumber)
	dash $HOME/monoliths-llm/debian-13-wireplumber.sh
	;;
    558|debian-14-xbindkeys)
	dash $HOME/monoliths-llm/debian-14-xbindkeys.sh
	;;
    559|debian-15-xinit)
	dash $HOME/monoliths-llm/debian-15-xinit.sh
	;;
    560|debian-16-xorg-server)
	dash $HOME/monoliths-llm/debian-16-xorg-server.sh
	;;
    561|debian-17-openfortivpn)
	dash $HOME/monoliths-llm/debian-17-openfortivpn.sh
	;;
    562|debian-17-pavucontrol)
	dash $HOME/monoliths-llm/debian-17-pavucontrol.sh
	;;
    563|debian-18-htop)
	dash $HOME/monoliths-llm/debian-18-htop.sh
	;;
    564|debian-18-network-manager)
	dash $HOME/monoliths-llm/debian-18-network-manager.sh
	;;
    565|debian-19-conky-all)
	dash $HOME/monoliths-llm/debian-19-conky-all.sh
	;;
    566|debian-19-gimp)
	dash $HOME/monoliths-llm/debian-19-gimp.sh
	;;
    567|debian-20-gnome-shell)
	dash $HOME/monoliths-llm/debian-20-gnome-shell.sh
	;;
    568|debian-20-linux-tools-common)
	dash $HOME/monoliths-llm/debian-20-linux-tools-common.sh
	;;
    569|debian-21-linux-tools-generic)
	dash $HOME/monoliths-llm/debian-21-linux-tools-generic.sh
	;;
    570|debian-21-thermald)
	dash $HOME/monoliths-llm/debian-21-thermald.sh
	;;
    571|debian-22-acpid)
	dash $HOME/monoliths-llm/debian-22-acpid.sh
	;;
    572|debian-23-avahi-daemon)
	dash $HOME/monoliths-llm/debian-23-avahi-daemon.sh
	;;
    573|debian-24-gimp)
	dash $HOME/monoliths-llm/debian-24-gimp.sh
	;;
    574|debian-25-htop)
	dash $HOME/monoliths-llm/debian-25-htop.sh
	;;
    575|debian-26-openfortivpn)
	dash $HOME/monoliths-llm/debian-26-openfortivpn.sh
	;;
    576|debian-27-st)
	dash $HOME/monoliths-llm/debian-27-st.sh
	;;
    577|debian-run-all)
	dash $HOME/monoliths-llm/debian-run-all.sh
	;;
    578|dev)
	dash $HOME/monoliths-llm/dev.sh
	;;
    579|dialog)
	dash $HOME/monoliths-llm/dialog.sh
	;;
    580|enfriar-asus)
	dash $HOME/monoliths-llm/enfriar-asus.sh
	;;
    581|enfriar-hp)
	dash $HOME/monoliths-llm/enfriar-hp.sh
	;;
    582|english-or-german-to-clipboard-on-spanish)
	dash $HOME/monoliths-llm/english-or-german-to-clipboard-on-spanish.sh
	;;
    583|exercises_fast)
	dash $HOME/monoliths-llm/exercises_fast.sh
	;;
    584|festival-de)
	dash $HOME/monoliths-llm/festival-de.sh
	;;
    585|gaming-mode-check)
	dash $HOME/monoliths-llm/gaming-mode-check.sh
	;;
    586|hibernacion_real)
	dash $HOME/monoliths-llm/hibernacion_real.sh
	;;
    587|init)
	dash $HOME/monoliths-llm/init.sh
	;;
    588|input-leap)
	dash $HOME/monoliths-llm/input-leap.sh
	;;
    589|install-antigravity-portable)
	dash $HOME/monoliths-llm/install-antigravity-portable.sh
	;;
    590|install-antigravity)
	dash $HOME/monoliths-llm/install-antigravity.sh
	;;
    591|install-google-chrome-stable)
	dash $HOME/monoliths-llm/install-google-chrome-stable.sh
	;;
    592|install-libatk-bridge)
	dash $HOME/monoliths-llm/install-libatk-bridge.sh
	;;
    593|install-libatspi)
	dash $HOME/monoliths-llm/install-libatspi.sh
	;;
    594|install-libdbus)
	dash $HOME/monoliths-llm/install-libdbus.sh
	;;
    595|install-libsystemd)
	dash $HOME/monoliths-llm/install-libsystemd.sh
	;;
    596|install-piper)
	dash $HOME/monoliths-llm/install-piper.sh
	;;
    597|internet)
	dash $HOME/monoliths-llm/internet.sh
	;;
    598|jira-reminder)
	dash $HOME/monoliths-llm/jira-reminder.sh
	;;
    599|loopback-tampermonkey-button-server)
	dash $HOME/monoliths-llm/loopback-tampermonkey-button-server.sh
	;;
    600|loopback-yad-normal)
	dash $HOME/monoliths-llm/loopback-yad-normal.sh
	;;
    601|loopback-yad-server)
	dash $HOME/monoliths-llm/loopback-yad-server.sh
	;;
    602|max_power)
	dash $HOME/monoliths-llm/max_power.sh
	;;
    603|message_img)
	dash $HOME/monoliths-llm/message_img.sh
	;;
    604|min_power)
	dash $HOME/monoliths-llm/min_power.sh
	;;
    605|modo_blob)
	dash $HOME/monoliths-llm/modo_blob.sh
	;;
    606|modo_optime)
	dash $HOME/monoliths-llm/modo_optime.sh
	;;
    607|ocr_core)
	dash $HOME/monoliths-llm/ocr_core.sh
	;;
    608|ocr_title_util)
	dash $HOME/monoliths-llm/ocr_title_util.sh
	;;
    609|ocr_traducir_captura_HP)
	dash $HOME/monoliths-llm/ocr_traducir_captura_HP.sh
	;;
    610|ocr_traducir_captura_HP_bk)
	dash $HOME/monoliths-llm/ocr_traducir_captura_HP_bk.sh
	;;
    611|ocr_traducir_captura_HP_googletranslate)
	dash $HOME/monoliths-llm/ocr_traducir_captura_HP_googletranslate.sh
	;;
    612|ops360-reminder)
	dash $HOME/monoliths-llm/ops360-reminder.sh
	;;
    613|peliculas)
	dash $HOME/monoliths-llm/peliculas.sh
	;;
    614|preparar_literatura)
	dash $HOME/monoliths-llm/preparar_literatura.sh
	;;
    615|preparar_literatura_bible)
	dash $HOME/monoliths-llm/preparar_literatura_bible.sh
	;;
    616|preparar_literatura_old)
	dash $HOME/monoliths-llm/preparar_literatura_old.sh
	;;
    617|ram-report)
	dash $HOME/monoliths-llm/ram-report.sh
	;;
    618|recscreencast)
	dash $HOME/monoliths-llm/recscreencast.sh
	;;
    619|recscreencast_1m)
	dash $HOME/monoliths-llm/recscreencast_1m.sh
	;;
    620|recscreencast_3m)
	dash $HOME/monoliths-llm/recscreencast_3m.sh
	;;
    621|recscreencast_counting)
	dash $HOME/monoliths-llm/recscreencast_counting.sh
	;;
    622|run-reminders)
	dash $HOME/monoliths-llm/run-reminders.sh
	;;
    623|screenshot)
	dash $HOME/monoliths-llm/screenshot.sh
	;;
    624|script-literatura-core)
	dash $HOME/monoliths-llm/script-literatura-core.sh
	;;
    625|script-literatura-lang)
	dash $HOME/monoliths-llm/script-literatura-lang.sh
	;;
    626|script-literatura-yad)
	dash $HOME/monoliths-llm/script-literatura-yad.sh
	;;
    627|script-literatura)
	dash $HOME/monoliths-llm/script-literatura.sh
	;;
    628|second-counter)
	dash $HOME/monoliths-llm/second-counter.sh
	;;
    629|set-jbl-mic-100-loop)
	dash $HOME/monoliths-llm/set-jbl-mic-100-loop.sh
	;;
    630|set-jbl-mic-100)
	dash $HOME/monoliths-llm/set-jbl-mic-100.sh
	;;
    631|share-the-last-video)
	dash $HOME/monoliths-llm/share-the-last-video.sh
	;;
    632|simple_second_counter-N-yad)
	dash $HOME/monoliths-llm/simple_second_counter-N-yad.sh
	;;
    633|simple_second_counter-N)
	dash $HOME/monoliths-llm/simple_second_counter-N.sh
	;;
    634|simple_second_counter)
	dash $HOME/monoliths-llm/simple_second_counter.sh
	;;
    635|simple_second_counter_xterm-N)
	dash $HOME/monoliths-llm/simple_second_counter_xterm-N.sh
	;;
    636|simple_second_feh_counter)
	dash $HOME/monoliths-llm/simple_second_feh_counter.sh
	;;
    637|sof-snd-dsp)
	dash $HOME/monoliths-llm/sof-snd-dsp.sh
	;;
    638|start_reader_system)
	dash $HOME/monoliths-llm/start_reader_system.sh
	;;
    639|suspender)
	dash $HOME/monoliths-llm/suspender.sh
	;;
    640|suspender_real)
	dash $HOME/monoliths-llm/suspender_real.sh
	;;
    641|training-on-left-seconds-a-range-of-N-minute)
	dash $HOME/monoliths-llm/training-on-left-seconds-a-range-of-N-minute.sh
	;;
    642|tts_german)
	dash $HOME/monoliths-llm/tts_german.sh
	;;
    643|tts_spanish)
	dash $HOME/monoliths-llm/tts_spanish.sh
	;;
    644|ubuntu-00-hacer-carpeta-de-trabajo)
	dash $HOME/monoliths-llm/ubuntu-00-hacer-carpeta-de-trabajo.sh
	;;
    645|ubuntu-01-emacs-29)
	dash $HOME/monoliths-llm/ubuntu-01-emacs-29.sh
	;;
    646|ubuntu-02-bash)
	dash $HOME/monoliths-llm/ubuntu-02-bash.sh
	;;
    647|ubuntu-03-blueman)
	dash $HOME/monoliths-llm/ubuntu-03-blueman.sh
	;;
    648|ubuntu-04-bluez)
	dash $HOME/monoliths-llm/ubuntu-04-bluez.sh
	;;
    649|ubuntu-05-chromium)
	dash $HOME/monoliths-llm/ubuntu-05-chromium.sh
	;;
    650|ubuntu-06-coreutils)
	dash $HOME/monoliths-llm/ubuntu-06-coreutils.sh
	;;
    651|ubuntu-07-dash)
	dash $HOME/monoliths-llm/ubuntu-07-dash.sh
	;;
    652|ubuntu-08-dbus)
	dash $HOME/monoliths-llm/ubuntu-08-dbus.sh
	;;
    653|ubuntu-09-grep)
	dash $HOME/monoliths-llm/ubuntu-09-grep.sh
	;;
    654|ubuntu-10-openbox)
	dash $HOME/monoliths-llm/ubuntu-10-openbox.sh
	;;
    655|ubuntu-11-pulseaudio)
	dash $HOME/monoliths-llm/ubuntu-11-pulseaudio.sh
	;;
    656|ubuntu-12-procps)
	dash $HOME/monoliths-llm/ubuntu-12-procps.sh
	;;
    657|ubuntu-13-pavucontrol)
	dash $HOME/monoliths-llm/ubuntu-13-pavucontrol.sh
	;;
    658|ubuntu-13-wireplumber)
	dash $HOME/monoliths-llm/ubuntu-13-wireplumber.sh
	;;
    659|ubuntu-14-xbindkeys)
	dash $HOME/monoliths-llm/ubuntu-14-xbindkeys.sh
	;;
    660|ubuntu-15-xinit)
	dash $HOME/monoliths-llm/ubuntu-15-xinit.sh
	;;
    661|ubuntu-16-xorg-server)
	dash $HOME/monoliths-llm/ubuntu-16-xorg-server.sh
	;;
    662|ubuntu-17-network-manager)
	dash $HOME/monoliths-llm/ubuntu-17-network-manager.sh
	;;
    663|ubuntu-19-gnome-shell)
	dash $HOME/monoliths-llm/ubuntu-19-gnome-shell.sh
	;;
    664|ubuntu-20-thermald)
	dash $HOME/monoliths-llm/ubuntu-20-thermald.sh
	;;
    665|ubuntu-21-acpid)
	dash $HOME/monoliths-llm/ubuntu-21-acpid.sh
	;;
    666|ubuntu-22-avahi-daemon)
	dash $HOME/monoliths-llm/ubuntu-22-avahi-daemon.sh
	;;
    667|ubuntu-23-openfortivpn)
	dash $HOME/monoliths-llm/ubuntu-23-openfortivpn.sh
	;;
    668|ubuntu-24-htop)
	dash $HOME/monoliths-llm/ubuntu-24-htop.sh
	;;
    669|ubuntu-25-gimp)
	dash $HOME/monoliths-llm/ubuntu-25-gimp.sh
	;;
    670|ubuntu-26-linux-tools-common)
	dash $HOME/monoliths-llm/ubuntu-26-linux-tools-common.sh
	;;
    671|ubuntu-27-linux-tools-generic)
	dash $HOME/monoliths-llm/ubuntu-27-linux-tools-generic.sh
	;;
    672|ubuntu-O3-firefox)
	dash $HOME/monoliths-llm/ubuntu-O3-firefox.sh
	;;
    673|ubuntu-check-running)
	dash $HOME/monoliths-llm/ubuntu-check-running.sh
	;;
    674|ubuntu-generate-missing)
	dash $HOME/monoliths-llm/ubuntu-generate-missing.sh
	;;
    675|ubuntu-run-all)
	dash $HOME/monoliths-llm/ubuntu-run-all.sh
	;;
    676|update-antigravity-portable)
	dash $HOME/monoliths-llm/update-antigravity-portable.sh
	;;
    677|update-antigravity)
	dash $HOME/monoliths-llm/update-antigravity.sh
	;;
    678|update-google-chrome-stable)
	dash $HOME/monoliths-llm/update-google-chrome-stable.sh
	;;
    679|update-libatk-bridge)
	dash $HOME/monoliths-llm/update-libatk-bridge.sh
	;;
    680|update-libatspi)
	dash $HOME/monoliths-llm/update-libatspi.sh
	;;
    681|update-libdbus)
	dash $HOME/monoliths-llm/update-libdbus.sh
	;;
    682|update-libsystemd)
	dash $HOME/monoliths-llm/update-libsystemd.sh
	;;
    683|validate-freebsd-this-machine)
	dash $HOME/monoliths-llm/validate-freebsd-this-machine.sh
	;;
    684|validate-openbsd-this-machine)
	dash $HOME/monoliths-llm/validate-openbsd-this-machine.sh
	;;
    685|validate-plan9-this-machine)
	dash $HOME/monoliths-llm/validate-plan9-this-machine.sh
	;;
    686|vociferate-core)
	dash $HOME/monoliths-llm/vociferate-core.sh
	;;
    687|vociferate-pdf)
	dash $HOME/monoliths-llm/vociferate-pdf.sh
	;;
    688|audio-sof|OUT=sof-snd-dsp-IN=sof-snd-dsp)
	export DISPLAY=:0
	bash $HOME/monoliths-llm/OUT=sof-snd-dsp-IN=sof-snd-dsp.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    689|audio-sof-filter|OUT=sof-snd-dsp-IN=sof-snd-dsp-IN-FILTER)
	bash $HOME/monoliths-llm/OUT=sof-snd-dsp-IN=sof-snd-dsp-IN-FILTER.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    690|audio-jbl|OUT=jbl-usb-wireless-IN=jbl-usb-wireless)
	bash $HOME/monoliths-llm/OUT=jbl-usb-wireless-IN=jbl-usb-wireless-CHROME-IN=sof-snd-dsp.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    691|audio-jbl-filter|OUT=jbl-usb-wireless-IN=jbl-usb-wireless-FILTER)
	bash $HOME/monoliths-llm/OUT=jbl-usb-wireless-IN=jbl-usb-wireless-FILTER-CHROME-IN=sof-snd-dsp.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    692|audio-jbl-loopback-jbl|OUT=jbl-usb-wireless-IN=jbl-usb-wireless-LOOPBACK=jbl-usb-wireless)
	bash $HOME/monoliths-llm/OUT=jbl-usb-wireless-IN=jbl-usb-wireless-LOOPBACK=jbl-usb-wireless-CHROME-IN=sof-snd-dsp.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    693|audio-jbl-filter-loopback-jbl|OUT=jbl-usb-wireless-IN=jbl-usb-wireless-FILTER-LOOPBACK=jbl-usb-wireless)
	bash $HOME/monoliths-llm/OUT=jbl-usb-wireless-IN=jbl-usb-wireless-FILTER-LOOPBACK=jbl-usb-wireless-CHROME-IN=sof-snd-dsp.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    694|audio-jbl-loopback-sof|OUT=jbl-usb-wireless-IN=jbl-usb-wireless-LOOPBACK=jbl-usb-wireless+IN=sof-snd-dsp)
	bash $HOME/monoliths-llm/OUT=jbl-usb-wireless-IN=jbl-usb-wireless-LOOPBACK=jbl-usb-wireless+IN=sof-snd-dsp-CHROME-IN=sof-snd-dsp.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    695|audio-jbl-filter-loopback-sof|OUT=jbl-usb-wireless-IN=jbl-usb-wireless-FILTER-LOOPBACK=jbl-usb-wireless+IN=sof-snd-dsp)
	bash $HOME/monoliths-llm/OUT=jbl-usb-wireless-IN=jbl-usb-wireless-FILTER-LOOPBACK=jbl-usb-wireless+IN=sof-snd-dsp-CHROME-IN=sof-snd-dsp.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    696|audio-qa-test|qa_audio_test_plan)
	bash $HOME/monoliths-llm/qa_audio_test_plan.sh
	pkill -9 chrome; sleep 0.1; setsid google-chrome-stable --use-alsa --disable-audio-service-sandbox --alsa-input-device=microfono_laptop
	;;
    697|audio-stop|detener-todos-los-modulos-de-audio|detener-todos-los-modulos-de-audio.sh)
	bash $HOME/monoliths-llm/detener-todos-los-modulos-de-audio.sh
	;;
    *)
	echo 'Opción no mapeada.'
	exit 1
	;;
esac
