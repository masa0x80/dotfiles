s() {
  local window_name=$(tmux display -p '#{window_name}')
  tmux rename-window ${window_name}/server
  command rails s -p $RAILS_SERVER_PORT
}

bundle() {
  command bundle $@
  if [[ $1 == install ]]; then
    if (( $+commands[gtags] && $+commands[cpulimit] && $+commands[tmux] )); then
      local log_file=/tmp/gtags-$$
      echo ''
      echo "${fg[magenta]}gtags error log: $log_file${fg[default]}"
      echo ''
      tmux split-window -v -l 1 "tmux select-pane -t :.-; cpulimit -i -l 30 gtags -v 2>&1 | tee $log_file"
    fi
  fi
}

alias ss="pkill -f 'ruby .*/bin/spring'; pkill -f 'spring app'; pkill -f 'spring server'"
alias c='rails c'
alias t='rspec'
alias bi='bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4'
alias bil='bi --local'
alias db='rails db'

alias -g RET='RAILS_ENV=test'
