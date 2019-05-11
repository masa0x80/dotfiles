rails() {
  if (( $+commands[rails] )); then
    local cmd="rails $@"
    if (( $+commands[spring] )); then
      cmd="spring $cmd"
    else
      cmd="command $cmd"
    fi
    eval "$cmd"
  else
    echo 'zsh: command not found: rails'
    return 1
  fi
}

rspec() {
  if (( $+commands[rspec] )); then
    local cmd="rspec $@"
    if (( $+commands[spring] )) && (spring --help | grep -q rspec); then
      cmd="spring $cmd"
    else
      cmd="command $cmd"
    fi
    eval "$cmd"
  else
    echo 'zsh: command not found: rspec'
    return 1
  fi
}
