export STARSHIP_CONFIG1="$HOME/.config/starship.toml"
export STARSHIP_CONFIG2="$HOME/.config/starship2.toml"

_switch_starship_config() {
  if [ "$STARSHIP_CONFIG" = "$STARSHIP_CONFIG1" ]; then
    STARSHIP_CONFIG="$STARSHIP_CONFIG2"
  else
    STARSHIP_CONFIG="$STARSHIP_CONFIG1"
  fi
  export STARSHIP_CONFIG
}
add-zsh-hook preexec _switch_starship_config

_set_window_name() {
  echo -ne "\033]2;$(current_dir)\007"
}
add-zsh-hook chpwd _set_window_name
