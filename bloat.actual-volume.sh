#!/bin/dash
# Check if optimized assembly/C volume binary exists
for _vbin in "$HOME/monoliths-hm/bin/volume_ctrl" "$HOME/.local/bin/volume_ctrl" "/usr/local/bin/volume_ctrl"; do
    if [ -x "$_vbin" ]; then
        exec "$_vbin" get
    fi
done
[ -f $HOME/.amixer_scontents ] && rm $HOME/.amixer_scontent*
echo $(amixer scontents Master | grep Playback) > $HOME/.amixer_scontents
emacs --batch -Q --eval="(progn (find-file \"$HOME/.amixer_scontents\") (setq last-kbd-macro (kbd \"M-d M-d M-d M-d M-d M-d M-d M-d M-d M-d C-d M-f C-f C-k C-x C-s\")) (call-last-kbd-macro) (save-buffers-kill-terminal 'silently))"
cat $HOME/.amixer_scontents
