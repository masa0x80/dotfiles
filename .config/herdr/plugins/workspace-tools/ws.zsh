#!/bin/zsh -f
# herdr workspace tools
#
# キーバインドから叩くのは action、fzf を使うものは TTY が必要なので
# action が popup ペイン（= plugin pane）を開き、その中で fzf を回す。
#
#   ws.zsh pick-workspace       fzf でワークスペースを選んでフォーカスする（popup を開く）
#   ws.zsh move-pane            現在のペインを fzf で選んだワークスペースへ移す（popup を開く）
#   ws.zsh picker-focus         ↑ の popup 側の実処理
#   ws.zsh picker-move          ↑ の popup 側の実処理
#   ws.zsh misc                 _misc ワークスペースを開く（あればフォーカス）
#   ws.zsh tab-move next|prev   タブの位置を前後に入れ替える
#   ws.zsh ws-move next|prev    ワークスペースの位置を前後に入れ替える
#   ws.zsh tab-select <n>       現在のワークスペースの n 番目のタブへ移る
#                               （正: 左から 1 起点 / 負: 右から -1 起点）
#   ws.zsh ws-select <n>        n 番目のワークスペースへ移る（同じ添字の規則）
#   ws.zsh terminal-id <pane>   pane の terminal_id（移動しても変わらない）を引く
#   ws.zsh tab-name <tid> <名>  terminal_id からタブを引いて名前を付ける

emulate -L zsh
setopt no_nomatch

# herdr サーバーの環境は対話シェルとは限らないので、最低限の PATH を補う
path=(
  /etc/profiles/per-user/$USER/bin(N-/)
  /run/current-system/sw/bin(N-/)
  /nix/var/nix/profiles/default/bin(N-/)
  /opt/homebrew/bin(N-/)
  $path
)

local herdr=${HERDR_BIN_PATH:-herdr}
local plugin=${HERDR_PLUGIN_ID:-workspace-tools}
local socket=${HERDR_SOCKET_PATH:-${XDG_CONFIG_HOME:-$HOME/.config}/herdr/herdr.sock}
local state_dir=${HERDR_PLUGIN_STATE_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/herdr/plugins/workspace-tools}
local src_file=$state_dir/src_pane
# プールは実装の都合で存在しているだけなので、選択肢には出さない
local pool_label=${HERDR_POOL_LABEL:-_pool}
local misc_label=${HERDR_MISC_LABEL:-_misc}

(( ${+commands[jq]} )) || exit 0

api() { $herdr "$@" 2>/dev/null }

# tab.move / workspace.move は CLI に出ていないので、ソケットへ直接投げる
raw() {
  local method=$1 params=$2 fd line
  zmodload zsh/net/socket 2>/dev/null || return 1
  zsocket $socket 2>/dev/null || return 1
  fd=$REPLY
  print -u $fd -r -- "{\"id\":\"ws.zsh\",\"method\":\"$method\",\"params\":$params}"
  read -u $fd -r line
  exec {fd}>&-
  print -r -- $line
}

open_picker() {
  api plugin pane open --plugin $plugin --entrypoint $1 \
    --placement popup --width 60% --height 40% >/dev/null
}

# "<workspace_id>\t<表示>" の一覧
ws_rows() {
  api workspace list | jq -r --arg pool $pool_label '
    .result.workspaces[]
    | select(.label != $pool)
    | "\(.workspace_id)\t\(if .focused then "*" else " " end) \(.label)"'
}

pick_ws() {
  local rows=$(ws_rows)
  [[ -n $rows ]] || return 1
  print -r -- $rows |
    fzf --layout=reverse --info=inline --no-multi --prompt="$1" \
      --delimiter=$'\t' --with-nth=2 |
    cut -f1
}

cmd_picker_focus() {
  local id=$(pick_ws 'workspace> ')
  [[ -n $id ]] || return 0
  api workspace focus $id >/dev/null
}

cmd_picker_move() {
  local src
  [[ -r $src_file ]] && src=$(<$src_file)
  rm -f $src_file
  [[ -n $src ]] || return 1
  local id=$(pick_ws 'move pane to> ')
  [[ -n $id ]] || return 0
  api pane move $src --new-tab --workspace $id --focus >/dev/null
}

cmd_move_pane() {
  # popup 自身が焦点を持つ可能性があるので、移動元は action 側で確定させておく
  local src=${HERDR_PANE_ID:-}
  [[ -n $src ]] || src=$(api pane current --current | jq -r '.result.pane.pane_id // empty')
  [[ -n $src ]] || return 1
  mkdir -p $state_dir
  print -r -- $src >$src_file
  open_picker picker-move
}

cmd_misc() {
  local id=$(api workspace list |
    jq -r --arg l $misc_label '.result.workspaces[] | select(.label == $l) | .workspace_id' |
    head -n1)
  if [[ -n $id ]]; then
    api workspace focus $id >/dev/null
    return
  fi

  # --cwd を渡さないので terminal.new_cwd の設定に従う
  local ws=$(api workspace create --label $misc_label --focus |
    jq -r '.result.workspace.workspace_id // empty')
  [[ -n $ws ]] || return 1

  local -a ids=(${(f)"$(api workspace list | jq -r '.result.workspaces[].workspace_id')"})
  local -i i=${ids[(Ie)$ws]}
  (( i > 1 )) && raw workspace.move "{\"workspace_id\":\"$ws\",\"insert_index\":0}" >/dev/null
}

# tab.move / workspace.move の insert_index は「元の並びでその位置にある要素の
# 手前へ差し込む」意味なので、後ろへ動かすときだけ 1 つ足す必要がある。
# 現在位置を dir 方向へ 1 つずらすための insert_index を返す（端は巻き戻る）。
insert_index() {
  local dir=$1 cur=$2
  shift 2
  local -a ids=("$@")
  (( $#ids > 1 )) || return 1
  local -i i=${ids[(Ie)$cur]}
  (( i )) || return 1

  local -i c=$(( i - 1 ))                                   # 0 起点の現在位置
  local -i p                                                # 0 起点の移動先
  if [[ $dir == next ]]; then
    (( p = (c + 1) % $#ids ))
  else
    (( p = (c - 1 + $#ids) % $#ids ))
  fi
  (( p > c )) && print -r -- $(( p + 1 )) || print -r -- $p
}

cmd_tab_move() {
  local dir=$1 ws=${HERDR_WORKSPACE_ID:-} cur=${HERDR_TAB_ID:-}
  [[ -n $ws && -n $cur ]] || return 1
  local -a ids=(${(f)"$(api tab list --workspace $ws | jq -r '.result.tabs[].tab_id')"})
  local n=$(insert_index $dir $cur $ids) || return 0
  [[ -n $n ]] || return 0
  raw tab.move "{\"tab_id\":\"$cur\",\"insert_index\":$n}" >/dev/null
}

cmd_ws_move() {
  local dir=$1 cur=${HERDR_WORKSPACE_ID:-}
  [[ -n $cur ]] || return 1
  local -a ids=(${(f)"$(api workspace list | jq -r '.result.workspaces[].workspace_id')"})
  local n=$(insert_index $dir $cur $ids) || return 0
  [[ -n $n ]] || return 0
  raw workspace.move "{\"workspace_id\":\"$cur\",\"insert_index\":$n}" >/dev/null
}

# zsh の添字は負数で末尾から数えられるので、左からの位置と右からの位置を同じ式で扱える
cmd_tab_select() {
  local -i idx=$1
  (( idx )) || return 1

  local ws=${HERDR_WORKSPACE_ID:-}
  [[ -n $ws ]] || ws=$(api pane current --current | jq -r '.result.pane.workspace_id // empty')
  [[ -n $ws ]] || return 1

  local -a ids=(${(f)"$(api tab list --workspace $ws | jq -r '.result.tabs[].tab_id')"})
  local tab=${ids[idx]}
  # タブ数が足りないときは何もしない
  [[ -n $tab ]] || return 0
  api tab focus $tab >/dev/null
}

# サイドバーの並びと番号が一致するよう、_pool も 1 枚として数える
cmd_ws_select() {
  local -i idx=$1
  (( idx )) || return 1
  local -a ids=(${(f)"$(api workspace list | jq -r '.result.workspaces[].workspace_id')"})
  local ws=${ids[idx]}
  [[ -n $ws ]] || return 0
  api workspace focus $ws >/dev/null
}

# pane_id はタブ / ワークスペース間の移動で変わるが terminal_id は変わらないので、
# シェルは起動時にこれを覚えておけば以後ずっと自分のタブを引ける
cmd_terminal_id() {
  local pane=$1
  [[ -n $pane ]] || return 1
  api pane get $pane | jq -r '.result.pane.terminal_id // empty'
}

cmd_tab_name() {
  local tid=$1 name=$2
  [[ -n $tid && -n $name ]] || return 1

  local tab ws
  IFS=$'\t' read -r tab ws <<<"$(api pane list |
    jq -r --arg t $tid '(.result.panes[] | select(.terminal_id == $t)) | "\(.tab_id)\t\(.workspace_id)"' |
    head -n1)"
  [[ -n $tab ]] || return 1

  # プールのタブは表に出ないので触らない
  local label=$(api workspace list |
    jq -r --arg w $ws '.result.workspaces[] | select(.workspace_id == $w) | .label')
  [[ $label == $pool_label ]] && return 0

  api tab rename $tab $name >/dev/null
}

case ${1:-} in
  pick-workspace) open_picker picker-focus ;;
  move-pane) cmd_move_pane ;;
  picker-focus) cmd_picker_focus ;;
  picker-move) cmd_picker_move ;;
  misc) cmd_misc ;;
  tab-move) cmd_tab_move ${2:-next} ;;
  ws-move) cmd_ws_move ${2:-next} ;;
  tab-select) cmd_tab_select ${2:-0} ;;
  ws-select) cmd_ws_select ${2:-0} ;;
  terminal-id) cmd_terminal_id ${2:-} ;;
  tab-name) cmd_tab_name ${2:-} ${3:-} ;;
  *)
    print -ru2 -- "usage: ws.zsh {pick-workspace|move-pane|misc|tab-move next|prev|ws-move next|prev|tab-select <n>|ws-select <n>|terminal-id <pane>|tab-name <tid> <name>}"
    exit 2
    ;;
esac
exit 0
