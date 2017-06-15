s() {
  local t_window=$(tmux list-windows | grep -E '\(active\)$' | cut -d ':' -f1)
  local t_pane=$(tmux list-pane | grep -E '\(active\)$' | cut -d ':' -f1)
  local window_name=$(tmux display -p '#{window_name}')
  tmux rename-window ${window_name}/server
  tmux split-window -t ":$t_window.$t_pane" -v -p 10 "tmux select-pane -t :.-; command rails s -p $RAILS_SERVER_PORT"
}

bundle() {
  local t_window=$(tmux list-windows | grep -E '\(active\)$' | cut -d ':' -f1)
  local t_pane=$(tmux list-pane | grep -E '\(active\)$' | cut -d ':' -f1)
  command bundle $@
  if [[ $1 == install ]]; then
    if (( $+commands[gtags] && $+commands[cpulimit] && $+commands[tmux] )); then
      local log_file=/tmp/gtags-$$
      echo ''
      echo "${fg[magenta]}gtags error log: $log_file${fg[default]}"
      echo ''
      tmux split-window -t ":$t_window.$t_pane" -v -l 1 "tmux select-pane -t :.-; cpulimit -i -l 30 gtags -v 2>&1 | tee $log_file"
    fi
  fi
}

alias ss='spring stop'
alias c='rails c'
alias t='rspec'
alias bi='bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4'
alias bil='bi --local'
alias db='rails db'

alias -g RET='RAILS_ENV=test'
