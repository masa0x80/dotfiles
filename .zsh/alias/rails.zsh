s() {
  local window_name=$(tmux display -p '#{window_name}')
  tmux rename-window ${window_name}/server
  command rails s -p $RAILS_SERVER_PORT
}

bundle() {
  command bundle $@
  if (( $+commands[gtags] )); then
    local log_file=/tmp/gtags-$$
    echo ''
    echo "${fg[magenta]}gtags error log: $log_file${fg[default]}"
    echo ''
    (gtags 2> $log_file) &
  fi
}

alias ss="pkill -f 'ruby .*/bin/spring'; pkill -f 'spring app'; pkill -f 'spring server'"
alias c='rails c'
alias t='rspec'
alias bi='bundle install'
alias bil='bundle install --local'
alias db='rails db'

alias -g BO='--path=vendor/bundle --binstubs=vendor/bin --jobs=4'
alias -g RET='RAILS_ENV=test'
