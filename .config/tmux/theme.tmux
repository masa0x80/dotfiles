# vim: ft=tmux

set -g status-position top
set -g renumber-windows on

# Configure the catppuccin plugin
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_text " #W"
set -g @catppuccin_window_current_text " #W"
set -g @catppuccin_window_status_style "slanted"
set -g @catppuccin_application_icon "󰆍 "
set -g @catppuccin_status_left_separator ""
set -g @catppuccin_status_middle_separator ""
set -g @catppuccin_status_right_separator ""
set -g @catppuccin_gitmux_icon ""
set -g @cpu_percentage_format "%4.1f%%"

# Load catppuccin
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

set -g @catppuccin_gitmux_text ' #(bash ~/.config/tmux/tmux-gitmux.sh "#{pane_current_path}")'

set -gqF "@catppuccin_status_claude" \
  "#[fg=#{@thm_mauve}]#[bg=default]#{@catppuccin_status_left_separator}"
set -agF "@catppuccin_status_claude" \
  "#[fg=#{@thm_crust},bg=#{@thm_mauve}]󰚩 "
set -agF "@catppuccin_status_claude" \
  "#{@catppuccin_status_middle_separator}"
set -agF "@catppuccin_status_claude" \
  "#[fg=#{@thm_fg},bg=#{E:@catppuccin_status_module_text_bg}]"
set -ag "@catppuccin_status_claude" " #(tmux-claude-agents)"
set -agF "@catppuccin_status_claude" \
  "#[fg=#{E:@catppuccin_status_module_text_bg}]#[bg=default]#{@catppuccin_status_right_separator}"

# Make the status line pretty and add some modules
set -g status-right-length 80
set -g status-left-length 100
set -g status-left ""
set -g status-right '#{?#(tmux-claude-agents),#{E:@catppuccin_status_claude},}'
set -ag status-right '#{?#(git -C "#{pane_current_path}" rev-parse --is-inside-work-tree 2>/dev/null),#{E:@catppuccin_status_gitmux},}'
set -ag status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -agF status-right "#{E:@catppuccin_status_battery}"

run ~/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux
run ~/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux
