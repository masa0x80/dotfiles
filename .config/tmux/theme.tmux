# vim: ft=tmux

# black        #282c34
# blue         #7fbbb3
# yellow       #e69875
# red          #e67e80
# white        #d3c6aa
# green        #a7c080
# visual_grey  #343f44
# comment_grey #475258

set -g mode-style "fg=#d3c6aa,bg=#475258"

set -g message-style "fg=#282c34,bg=#7fbbb3"
set -g message-command-style "fg=#282c34,bg=#7fbbb3"

set -g pane-border-style "fg=#343f44"
set -g pane-active-border-style "fg=#475258"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#475258,bg=#282c34"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#282c34,bg=#282c34,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#282c34,bg=#282c34,nobold,nounderscore,noitalics]#[fg=#3e4452,bg=#282c34,nobold,nounderscore,noitalics]#[fg=#d3c6aa,bg=#3e4452] #(cd #{pane_current_path}; test \"$(git rev-parse --is-inside-work-tree 2>/dev/null)\" = 'true' && echo \" $(git branch --show-current) | \")%Y-%m-%d | %H:%M "

setw -g window-status-activity-style "underscore,fg=#e69875,bg=#282c34"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#475258,bg=#282c34"
setw -g window-status-format "#[fg=#475258,bg=#282c34,nobold,nounderscore,noitalics]#[fg=#d3c6aa,bg=#475258]###I #W #F#[fg=#475258,bg=#282c34,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#a7c080,bg=#282c34,nobold,nounderscore,noitalics]#[fg=#282c34,bg=#a7c080]###I #W #F#[fg=#a7c080,bg=#282c34,nobold,nounderscore,noitalics]"

set -g status-position top
