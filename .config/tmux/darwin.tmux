# vim: ft=tmux
source $XDG_CONFIG_HOME/tmux/copy.tmux

bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'pbcopy'
bind -T copy-mode-vi y     send -X copy-pipe-and-cancel 'pbcopy'
