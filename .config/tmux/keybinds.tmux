# vim: ft=tmux

# Window名変更
bind A command-prompt -I '#W' 'rename-window %%'

# Sessionをプールしておき、new-windowやsplit-window時に使う
set-hook -g session-created 'run-shell "\
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool"; \
  tmux has-session -t _popup 2>/dev/null || tmux new-session -d -s _popup"'

# Paneフォーカス時にpoolのカレントディレクトリーを変更する
set-hook -g pane-focus-in 'run-shell "\
  tmux has-session -t _pool 2>/dev/null && \
  tmux send-keys -t _pool \" cd \\\"#{pane_current_path}\\\" && clear\" Enter"'

# new-window (poolしてあるsessionを使う）
bind c run-shell '\
  path="#{pane_current_path}"; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool; \
  pane=$(tmux list-windows -t _pool -F "##{window_index} ##{pane_id}" | head -1 | awk "{print \$2}"); \
  if [ -n "$pane" ]; then \
    win=$(tmux list-windows -t _pool -F "##{window_index}" | head -1); \
    tmux move-window -a -s "_pool:$win"; \
    tmux select-window -t "$pane"; \
  else \
    tmux new-window -a -c "${pane_current_path}"; \
  fi; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool'
bind C run-shell '\
  path="#{pane_current_path}"; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool; \
  pane=$(tmux list-windows -t _pool -F "##{window_index} ##{pane_id}" | head -1 | awk "{print \$2}"); \
  if [ -n "$pane" ]; then \
    win=$(tmux list-windows -t _pool -F "##{window_index}" | head -1); \
    tmux move-window -b -s "_pool:$win"; \
    tmux select-window -t "$pane"; \
  else \
    tmux new-window -a -c "${pane_current_path}"; \
    tmux swap-window -t :-; \
    tmux select-window -t :-; \
  fi; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool'

# next / prev window
bind -r C-n next-window
bind -r C-p previous-window

bind q select-window -t 1
bind w select-window -t 2
bind e select-window -t 3
bind i select-window -t '{end}'\; select-window -t :-2
bind o select-window -t '{end}'\; select-window -t :-
bind p select-window -t '{end}'
bind 8 select-window -t '{end}'\; select-window -t :-2
bind 9 select-window -t '{end}'\; select-window -t :-
bind 0 select-window -t '{end}'

# Toggle Window
bind C-s last-window

bind * list-client

# Windowの移動
bind P swap-window -t :-\; select-window -t :-
bind N swap-window -t :+\; select-window -t :+
bind I swap-window -t :-\; select-window -t :-
bind O swap-window -t :+\; select-window -t :+

# Paneの移動
bind > join-pane -t :+
bind < join-pane -t :-
bind J command-prompt -1 'join-pane -ht :%%'

# Pane分割 (poolしてあるsessionを使う）
bind - run-shell '\
  path="#{pane_current_path}"; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool; \
  pane=$(tmux list-windows -t _pool -F "##{window_index} ##{pane_id}" | head -1 | awk "{print \$2}"); \
  if [ -n "$pane" ]; then \
    win=$(tmux list-windows -t _pool -F "##{window_index}" | head -1); \
    tmux join-pane -v -s "_pool:$win"; \
  else \
    tmux split-window -v -c "${pane_current_path}"; \
  fi; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool'
bind \\ run-shell '\
  path="#{pane_current_path}"; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool; \
  pane=$(tmux list-windows -t _pool -F "##{window_index} ##{pane_id}" | head -1 | awk "{print \$2}"); \
  if [ -n "$pane" ]; then \
    win=$(tmux list-windows -t _pool -F "##{window_index}" | head -1); \
    tmux join-pane -h -s "_pool:$win"; \
  else \
    tmux split-window -h -c "$path"; \
  fi; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool'
bind \; run-shell '\
  path="#{pane_current_path}"; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool; \
  pane=$(tmux list-windows -t _pool -F "##{window_index} ##{pane_id}" | head -1 | awk "{print \$2}"); \
  if [ -n "$pane" ]; then \
    win=$(tmux list-windows -t _pool -F "##{window_index}" | head -1); \
    tmux join-pane -h -s "_pool:$win"; \
  else \
    tmux split-window -h -c "${pane_current_path}"; \
  fi; \
  tmux has-session -t _pool 2>/dev/null || tmux new-session -d -s _pool'

bind r rotate-window
bind C-r rotate-window
# ^i は Tab
bind Tab select-pane -t :.+
bind C-o select-pane -t :.-

bind Q confirm-before 'kill-pane'

bind C-h select-pane -L
bind C-j select-pane -D
bind C-k select-pane -U
bind C-l select-pane -R

# ペインのリサイズする
bind -r H resize-pane -L 3
bind -r J resize-pane -D 3
bind -r K resize-pane -U 3
bind -r L resize-pane -R 3

bind U resize-pane -U 50
bind D resize-pane -D 50

bind M-h select-layout even-horizontal
bind M-v select-layout even-vertical
bind _ select-layout main-horizontal
bind | select-layout main-vertical
bind : select-layout main-vertical
bind Space select-layout tiled

# synchronize
bind S set-window-option synchronize-panes on
bind s set-window-option synchronize-panes off

# source
bind R source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display 'source $XDG_CONFIG_HOME/tmux/tmux.conf'

### copy-mode
bind C-f copy-mode \; display 'Copy mode'
bind C-[ copy-mode \; display 'Copy mode'

# コピーモードでのカーソル移動を vim 風に
set-window-option -g mode-keys vi
bind C-v paste-buffer

# 矩形選択
bind -T copy-mode-vi C-v send -X rectangle-toggle

# for mac
bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'pbcopy'
bind -T copy-mode-vi y     send -X copy-pipe-and-cancel 'pbcopy'

# Popup
bind -n C-q run-shell "tmux-popup 90% 90%"
