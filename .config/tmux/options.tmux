# vim: ft=tmux

set-option -g prefix C-s
set-option -g mouse on
set-option -g focus-event on

set-option -g status-interval 1

set -g default-terminal "$TERM"

set -s extended-keys on

# キーストロークのDelayを減らす
set -s escape-time 0

set -g cursor-style 'blinking-bar'
set -g base-index 1
