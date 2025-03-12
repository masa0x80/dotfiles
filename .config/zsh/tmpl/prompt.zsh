_switch_starship_config() {
  counter=$(expr $(expr ${counter:-1} + 1) % 2)
  if [ $counter -eq 0 ]; then
    export STARSHIP_CONFIG=$HOME/.config/starship.toml
  else
    export STARSHIP_CONFIG=$HOME/.config/starship2.toml
  fi
}
add-zsh-hook precmd _switch_starship_config
