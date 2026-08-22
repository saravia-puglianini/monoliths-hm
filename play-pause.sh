#!/bin/sh
for _ppbin in "$HOME/monoliths-hm/bin/play_pause_mpris" "$HOME/.local/bin/play_pause_mpris" "/usr/local/bin/play_pause_mpris"; do
    if [ -x "$_ppbin" ]; then
        exec "$_ppbin"
    fi
done
for player in $(dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | awk '/org.mpris.MediaPlayer2./ {split($0, a, "\""); print a[2]}'); do
    dbus-send --print-reply --dest=$player /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
done
