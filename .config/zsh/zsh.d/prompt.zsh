# timeoutなどのWARNはプロンプトを汚すので抑制
export STARSHIP_LOG=error

# コマンド実行ごとにプロンプトの顔を「ミ」「彡」で切り替える
# 顔は starship.toml の env_var.STARSHIP_FACE_OK / env_var.STARSHIP_FACE_NG で表示する
_starship_face=ミ
_toggle_starship_face() {
  [[ $_starship_face == ミ ]] && _starship_face=彡 || _starship_face=ミ
}
add-zsh-hook preexec _toggle_starship_face

# 色を character と揃えるため、成功・失敗で別の変数に入れる
# STARSHIP_CMD_STATUS は先に登録された starship の precmd が保存した直前のステータス
_export_starship_face() {
  unset STARSHIP_FACE_OK STARSHIP_FACE_NG
  if (( ${STARSHIP_CMD_STATUS:-0} == 0 )); then
    export STARSHIP_FACE_OK=$_starship_face
  else
    export STARSHIP_FACE_NG=$_starship_face
  fi
}
add-zsh-hook precmd _export_starship_face

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
