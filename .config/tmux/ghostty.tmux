set -g default-terminal "tmux-256color"
set -as terminal-features ",xterm-ghostty:RGB"

# ^i は Tab
bind Tab select-pane -t :.+
