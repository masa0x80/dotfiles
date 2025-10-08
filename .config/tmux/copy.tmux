# vim: ft=tmux
bind ^f copy-mode \; display 'Copy mode'
bind ^[ copy-mode \; display 'Copy mode'

# コピーモードでのカーソル移動を vim 風に
set-window-option -g mode-keys vi
bind p paste-buffer

# 矩形選択
bind -T copy-mode-vi C-v send -X rectangle-toggle
