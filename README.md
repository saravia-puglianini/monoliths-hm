# Monoliths HM (Home & Machine Environment Configuration)

Este repositorio contiene la configuración del entorno gráfico de usuario, scripts de utilidad del sistema, perfiles de automatización y herramientas de asistencia. Este documento describe detalladamente el funcionamiento y las dependencias requeridas para cada uno de los componentes clave.

---

## 🖥️ 1. Configuración de Inicio de Sesión (`.xinitrc` / `xprofile`)

El archivo [xinitrc](file:///home/user/monoliths-hm/xinitrc) y su complemento [xprofile](file:///home/user/monoliths-hm/xprofile) se encargan de inicializar el entorno gráfico X11 (usando mayormente **Openbox** como gestor de ventanas).

### Dependencias Principales del Sistema
* **`openbox`** (ejecutable: `openbox-session`): Gestor de ventanas ligero y altamente configurable.
* **`xbindkeys`**: Demonio que captura atajos de teclado globales definidos en `~/.xbindkeysrc`.
* **`feh`**: Visualizador de imágenes ligero usado para establecer el fondo de pantalla:
  ```bash
  feh --bg-scale $HOME/monoliths-hm/white-background.png
  ```
* **`xcalib`**: Utilidad de calibración de color. Se usa para ajustar pantallas o invertir colores en caliente:
  ```bash
  xcalib -i -a
  ```
* **`picom`**: Compositor de ventanas para X11. Usado para sombreados y efectos visuales avanzados, incluyendo el modo de pantalla en blanco y negro/monocromo mediante un fragment shader personalizado:
  ```bash
  picom --backend glx --no-fading-openclose --inactive-opacity=1.0 --active-opacity=1.0 --frame-opacity=1.0 --no-use-damage --window-shader-fg $HOME/monoliths-llm/blackandwhite.frag
  ```
* **`xinput`**: Permite habilitar/deshabilitar dispositivos de entrada dinámicamente (ej. silenciar el touchpad automáticamente al iniciar si se detecta corriente, o configurar aceleración de hardware para teclados/trackballs específicos como *SONiX Perixx Trackball Keyboard Mouse*).
* **`dbus-launch`**: Inicializa el bus de mensajes D-Bus de sesión en caso de que falte.
* **`doas` / `sudo`**: Herramientas de escalado de privilegios para controlar configuraciones de hardware en caliente (como deshabilitar el turbo-boost de Intel para ahorrar energía, apagar LEDs de antenas Wi-Fi TP-Link, remover el pitido de sistema con `rmmod pcspkr` o controlar velocidades de ventiladores mediante scripts como `enfriar-hp.sh` / `enfriar-asus.sh`).
* **`wmctrl`**: Herramienta de control de ventanas EWMH/NetWM (usada para comprobar si Google Chrome ya está corriendo, ocultar la interfaz gráfica de *InputLeap*, etc.).
* **`xdotool`**: Simula pulsaciones de teclado y movimientos del cursor del mouse (utilizado para automatizar la conexión e introducción de IPs en herramientas de escritorio compartido).
* **`st`**: El emulador de terminal simple (*Simple Terminal* de suckless) utilizado como fallback de consola.
* **`osd_cat`** (paquete `xosd-bin`): Despliega texto directamente sobre la pantalla como capa transparente flotante para cuentas atrás visuales de macros de automatización.
* **`deskflow-server` / `input-leap`**: Sistemas KVM por software para compartir teclado y mouse con otros computadores a través de la red local.

### Automatizaciones Específicas integradas en `.xinitrc`
* **Scrcpy + ADB + sdl_cursor_hook**: Inicializa una sesión de duplicación de pantalla para celulares Android conectados vía USB con inyección de cursor a nivel de librería de sistema (`LD_PRELOAD=/home/user/lib/sdl_cursor_hook.so scrcpy -d`).
* **Soporte Multi-TTY**:
  * **TTY 1**: Inicia Emacs principal, el menú dinámico YAD de LLM, Google Chrome, Scrcpy y el IDE Antigravity.
  * **TTY 2**: Inicia Gromit-MPX (anotación en pantalla), Chromium con aplicaciones web webmail y accesos locales.
  * **TTY 3**: Inicia lector de literatura en Español, scripts de estadísticas/hora flotante (`optime.personal_osdx.sh`).
  * **TTY 4**: Inicia literatura en Alemán.

---

## 🎛️ 2. Menú de Interfaz Gráfica (`a-llm-yad.sh`)

Ubicado en `~/monoliths-llm/a-llm-yad.sh`, este script proporciona un menú interactivo gráfico elegante que envuelve a la interfaz por consola de `my.shell.sh`.

### Dependencias requeridas
* **`yad`**: (*Yet Another Dialog*) Herramienta para desplegar cuadros de diálogo y listas gráficas interactivas basadas en GTK desde scripts.
* **`dash`**: Shell estándar POSIX rápido utilizado para interpretar los scripts sin la sobrecarga de bash.
* **`awk`**: Motor de procesamiento de texto con el que se parsea el menú estructurado de `my.shell.sh` en caliente para alimentar la grilla de YAD.

### Cómo funciona
1. Lee dinámicamente las opciones listadas en [my.shell.sh](file:///home/user/monoliths-hm/my.shell.sh) buscando patrones del tipo `N) Comando - Descripcion`.
2. Procesa la salida estructurando tres columnas: ID numérico (oculto), Nombre del Comando, y Descripción detallada.
3. Despliega una ventana gráfica interactiva de búsqueda y selección.
4. Al hacer doble clic o pulsar "Ejecutar", pasa de forma asíncrona la entrada numérica al shell orquestador:
   ```bash
   echo "$SELECTED_ID" | dash "$HOME/monoliths-hm/my.shell.sh"
   ```

---

## 🗣️ 3. Comandos de Vociferación (TTS) y Traducción

El sistema cuenta con scripts y utilidades para generar voz artificial (Text-to-Speech) a partir de texto seleccionado, capturas de pantalla con OCR o documentos en **Español (es)**, **Inglés (en)** y **Alemán (de)**.

### A. Motor Piper (TTS Local Offline de alta calidad)
El sistema utiliza principalmente **Piper**, un motor neuronal rápido y optimizado para ejecutarse localmente.
* **Ubicación obligatoria**: Debe estar instalado en `~/piper` junto con sus modelos de voz `.onnx` y archivos de configuración `.onnx.json`.
* **Modeles configurados**:
  * **Español (es)**: `es_MX-claude-high.onnx` o `es_MX-ald-medium.onnx`
  * **Inglés (en)**: `en_US-ryan-high.onnx`
  * **Alemán (de)**: `de_DE-thorsten-high.onnx`

#### Comandos base para Vociferar con Piper (Consola)
* **Español (es)**:
  ```bash
  echo "Hola, bienvenido a la automatización." | ~/piper/piper --model ~/piper/es_MX-claude-high.onnx --output_file /tmp/output.wav && mpv --no-video --quiet /tmp/output.wav
  ```
* **Inglés (en)**:
  ```bash
  echo "Hello, welcome to this automated system." | ~/piper/piper --model ~/piper/en_US-ryan-high.onnx --output_file /tmp/output.wav && mpv --no-video --quiet /tmp/output.wav
  ```
* **Alemán (de)**:
  ```bash
  echo "Hallo, willkommen in diesem automatisierten System." | ~/piper/piper --model ~/piper/de_DE-thorsten-high.onnx --output_file /tmp/output.wav && mpv --no-video --quiet /tmp/output.wav
  ```

---

### B. Motor Festival (TTS Híbrido)
Utilizado de forma alternativa en scripts como `tts_spanish.sh` y `tts_german.sh` para procesar y adaptar la fonética mediante filtros `sed` antes de reproducirlos con el lector inglés nativo de Festival.
* **Dependencias**: `festival`, `text2wave`, `mpv`.
* **Comandos base**:
  ```bash
  # Alemán (de) usando tts_german.sh:
  ~/monoliths-llm/tts_german.sh "Guten Morgen"
  
  # Español (es) usando tts_spanish.sh:
  ~/monoliths-llm/tts_spanish.sh "Buenos días"
  ```

---

### C. Captura de Pantalla + OCR + Traducción + Vociferación (`ocr_vociferar_*`)
Ubicado en `~/monoliths-llm/ocr_vociferar_de_HP` (y variantes de Asus/HP para `es`/`en`/`de`), permite tomar una captura de pantalla interactiva, procesar el texto con OCR, traducirlo y vociferarlo.
* **Dependencias**: `scrot`, `tesseract-ocr` (con los paquetes de idioma `tesseract-ocr-spa`, `tesseract-ocr-deu`, `tesseract-ocr-eng`), `apertium` (para traducciones offline) y los traductores compilados en `~/googletrans/dist/googletrans-es` (u homólogos `en`/`de` basados en la librería de Python `deep-translator`).

#### Comportamiento del script de captura
* El script determina su comportamiento dinámicamente mediante enlaces simbólicos:
  * Si es invocado como `ocr_vociferar_es_HP`: Toma una captura, extrae texto en Alemán/Inglés, y lo lee directamente en Español.
  * Si es invocado como `ocr_traducir_de_HP`: Captura pantalla, extrae el texto, lo traduce al Alemán (online vía Google o offline vía Apertium) y lo lee usando la voz alemana de Piper.

---

## ⌨️ 4. Control de Cursor por Teclado (`~/type-to-move-cursor`)

Ubicado en `~/type-to-move-cursor`, este subsistema permite reemplazar completamente el uso del mouse físico mediante combinaciones de teclas utilizando atajos rápidos de `xbindkeys`.

### Dependencias Requeridas
* **`xbindkeys`**: Administrador de atajos de teclado para el entorno X.
* **`xdotool`**: Para simular desplazamientos relativos, absolutos, arrastres y clics del puntero.
* **`herbe`** / **`xosd`**: Para desplegar alertas rápidas del cambio de modo en pantalla.
* **`tk` / `python-pyqt`**: Requerido para renderizar la documentación de ayuda gráfica contextual (`info_show.py`).

### Activación y Uso
El sistema cambia la configuración de `~/.xbindkeysrc` dinámicamente sobreescribiendo el archivo de configuración activo para alternar entre dos estados globales:

1. **Activar Modo Ratón por Teclado (`Alt + 2`)**:
   Intercambia los bindings de teclas normales por macros de movimiento del cursor. Las teclas del teclado alfanumérico simularán clics del mouse, scroll de rueda y desplazamientos direccionales.
   * Ejecuta tras bambalinas:
     ```bash
     dash ~/type-to-move-cursor/activate-type-to-move-cursor.sh
     ```
2. **Desactivar Modo Ratón / Regresar a Escritura Normal (`Alt + 1`)**:
   Restaura la configuración de teclado típica de entrada de caracteres.
   * Ejecuta tras bambalinas:
     ```bash
     dash ~/type-to-move-cursor/deactivate-type-to-move-cursor.sh
     ```

### Manuales de Uso en Varios Idiomas
Puedes abrir la guía interactiva según tu preferencia idiomática:
```bash
# Español
python3 ~/type-to-move-cursor/info_show.py ~/type-to-move-cursor/info.es.txt

# Inglés
python3 ~/type-to-move-cursor/info_show.py ~/type-to-move-cursor/info.us.txt

# Alemán
python3 ~/type-to-move-cursor/info_show.py ~/type-to-move-cursor/info.de.txt
```
