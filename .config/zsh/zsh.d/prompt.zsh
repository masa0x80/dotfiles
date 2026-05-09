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
  if [[ -n $TMUX ]]; then
    tmux rename-window -t $(tmux display-message -p -t "$TMUX_PANE" '#I') "$(current_dir)"
  fi
}
add-zsh-hook chpwd _set_window_name
