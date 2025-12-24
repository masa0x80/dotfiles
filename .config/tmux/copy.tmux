# vim: ft=tmux
bind C-f copy-mode \; display 'Copy mode'
bind C-[ copy-mode \; display 'Copy mode'

# コピーモードでのカーソル移動を vim 風に
set-window-option -g mode-keys vi
bind P paste-buffer

# 矩形選択
bind -T copy-mode-vi C-v send -X rectangle-toggle
