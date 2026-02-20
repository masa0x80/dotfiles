# vim: ft=tmux

set -g status-position top
set -g renumber-windows on

# Configure the catppuccin plugin
set -g @catppuccin_flavor "macchiato"
set -g @catppuccin_window_status_style "slanted"
set -g @catppuccin_application_icon "󰆍 "
set -g @catppuccin_status_left_separator ""
set -g @catppuccin_status_middle_separator ""
set -g @catppuccin_status_right_separator ""

# Load catppuccin
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

# Make the status line pretty and add some modules
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -agF status-right "#{E:@catppuccin_status_battery}"
set -agF status-right "#{@catppuccin_status_gitmux}"

run ~/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux
run ~/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux
