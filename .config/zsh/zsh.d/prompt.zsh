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

_herdr_ws_tool="${XDG_CONFIG_HOME:-$HOME/.config}/herdr/plugins/workspace-tools/ws.zsh"

# pane_id は移動で変わるので、起動時に不変の terminal_id を覚えておく
_herdr_my_terminal_id() {
  if [[ -z $_herdr_terminal_id && -n $HERDR_PANE_ID ]]; then
    _herdr_terminal_id="$("$_herdr_ws_tool" terminal-id "$HERDR_PANE_ID" 2>/dev/null)"
  fi
  [[ -n $_herdr_terminal_id ]]
}

_set_window_name() {
  [[ -n $HERDR_ENV && -x $_herdr_ws_tool ]] || return
  # CWDが変わったときだけ herdr を叩く
  [[ $PWD == "$_herdr_last_pwd" ]] && return
  _herdr_my_terminal_id || return
  _herdr_last_pwd="$PWD"

  # cd では pane.focused が飛ばないので名称変更をここで行う
  ("$_herdr_ws_tool" rename-tab-name "$_herdr_terminal_id" &) >/dev/null 2>&1
  ("$_herdr_ws_tool" rename-space-names &) >/dev/null 2>&1
}
add-zsh-hook precmd _set_window_name
