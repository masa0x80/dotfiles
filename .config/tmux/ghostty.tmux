set -g default-terminal "tmux-256color"
set -as terminal-features ",xterm-ghostty:RGB"

# ^8 は BSpace
bind BSpace select-window -t '{end}'\; select-window -t :-2
# ^i は Tab
bind Tab select-pane -t :.+
