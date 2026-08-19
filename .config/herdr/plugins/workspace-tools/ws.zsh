#!/bin/zsh -f
# herdr workspace tools
#
#   ws.zsh pick-workspace          fzf で workspace を選んで focus する（popup を開く）
#   ws.zsh move-pane               現在の pane を fzf で選んだ workspace へ移す（popup を開く）
#   ws.zsh focus-picker            ↑ の popup 側の実処理
#   ws.zsh move-picker             ↑ の popup 側の実処理
#   ws.zsh misc                    _misc workspace を開く（あればフォーカス）
#   ws.zsh move-tab next|prev      tab の位置を前後に入れ替える
#   ws.zsh join-move next|prev     現在の pane を隣の tab へ join する
#   ws.zsh move-ws next|prev       workspace の位置を前後に入れ替える
#   ws.zsh select-tab <n>          現在の workspace の n 番目の tab へ移る
#                                  （正: 左から 1 起点 / 負: 右から -1 起点）
#   ws.zsh select-ws <n>           n 番目の workspace へ移る（同じ添字の規則）
#   ws.zsh jump-blocked            blocked な agent に飛ぶ
#   ws.zsh terminal-id <pane>      pane の terminal_id（移動しても変わらない）を引く
#   ws.zsh rename-tab-name <tid>   terminal_id から tab を引いて名前を付ける
#   ws.zsh rename-space-names      SidebarのSpace名をつけ直す

emulate -L zsh
setopt no_nomatch

# herdr サーバーの環境は対話シェルとは限らないので、最低限の PATH を補う
# current_dir が $HOME/.bin にあるのでそこにも PATH を通す
path=(
  /etc/profiles/per-user/$USER/bin(N-/)
  /run/current-system/sw/bin(N-/)
  /nix/var/nix/profiles/default/bin(N-/)
  /opt/homebrew/bin(N-/)
  $HOME/.bin(N-/)
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
local space_token=${HERDR_SPACE_TOKEN:-space}

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
  api workspace list | jq -r --arg pool $pool_label --arg t $space_token '
    .result.workspaces[]
    | select(.label != $pool)
    | (if (.tokens[$t] // "") == "" then .label else .tokens[$t] end) as $name
    | "\(.workspace_id)\t\(if .focused then "*" else " " end) \($name)"'
}

# SPECIAL WORKSPACE ID
local new_ws_key='+new'

pick_ws() {
  local rows=$(ws_rows) head=$2
  [[ -n $rows || -n $head ]] || return 1
  {
    [[ -n $head ]] && printf '%s\t+ %s\n' $new_ws_key $head
    [[ -n $rows ]] && print -r -- $rows
  } |
    fzf --layout=reverse --info=inline --no-multi --prompt="$1" \
      --delimiter=$'\t' --with-nth=2 |
    cut -f1
}

cmd_focus_picker() {
  local id=$(pick_ws 'workspace> ')
  [[ -n $id ]] || return 0
  api workspace focus $id >/dev/null
}

cmd_move_picker() {
  local src
  [[ -r $src_file ]] && src=$(<$src_file)
  rm -f $src_file
  [[ -n $src ]] || return 1
  local id=$(pick_ws 'move pane to> ' 'new workspace')
  [[ -n $id ]] || return 0

  if [[ $id == "$new_ws_key" ]]; then
    api pane move $src --new-workspace --focus >/dev/null
    return
  fi

  api pane move $src --new-tab --workspace $id --focus >/dev/null
}

cmd_move_pane() {
  # popup 自身が焦点を持つ可能性があるので、移動元は action 側で確定させておく
  local src=${HERDR_PANE_ID:-}
  [[ -n $src ]] || src=$(api pane current --current | jq -r '.result.pane.pane_id // empty')
  [[ -n $src ]] || return 1
  mkdir -p $state_dir
  print -r -- $src >$src_file
  open_picker move-picker
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

cmd_move_tab() {
  local dir=$1 ws=${HERDR_WORKSPACE_ID:-} cur=${HERDR_TAB_ID:-}
  [[ -n $ws && -n $cur ]] || return 1
  local -a ids=(${(f)"$(api tab list --workspace $ws | jq -r '.result.tabs[].tab_id')"})
  local n=$(insert_index $dir $cur $ids) || return 0
  [[ -n $n ]] || return 0
  raw tab.move "{\"tab_id\":\"$cur\",\"insert_index\":$n}" >/dev/null
}

cmd_join_tab() {
  local dir=$1 ws=${HERDR_WORKSPACE_ID:-} cur=${HERDR_TAB_ID:-} pane=${HERDR_PANE_ID:-}
  [[ -n $pane ]] || pane=$(api pane current --current | jq -r '.result.pane.pane_id // empty')
  [[ -n $pane && -n $ws && -n $cur ]] || return 1

  local -a ids=(${(f)"$(api tab list --workspace $ws | jq -r '.result.tabs[].tab_id')"})
  (( $#ids > 1 )) || return 0
  local -i i=${ids[(Ie)$cur]}
  (( i )) || return 1

  local -i n=$#ids p
  if [[ $dir == next ]]; then
    (( p = i % n + 1 ))
  else
    (( p = (i + n - 2) % n + 1 ))
  fi
  api pane move $pane --tab ${ids[p]} --split right --focus >/dev/null
}

cmd_move_ws() {
  local dir=$1 cur=${HERDR_WORKSPACE_ID:-}
  [[ -n $cur ]] || return 1
  local -a ids=(${(f)"$(api workspace list | jq -r '.result.workspaces[].workspace_id')"})
  local n=$(insert_index $dir $cur $ids) || return 0
  [[ -n $n ]] || return 0
  raw workspace.move "{\"workspace_id\":\"$cur\",\"insert_index\":$n}" >/dev/null
}

# zsh の添字は負数で末尾から数えられるので、左からの位置と右からの位置を同じ式で扱える
cmd_select_tab() {
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
cmd_select_ws() {
  local -i idx=$1
  (( idx )) || return 1
  local -a ids=(${(f)"$(api workspace list | jq -r '.result.workspaces[].workspace_id')"})
  local ws=${ids[idx]}
  [[ -n $ws ]] || return 0
  api workspace focus $ws >/dev/null
}

cmd_jump_blocked() {
  local -a ids=(${(f)"$(api agent list |
    jq -r '.result.agents[] | select(.agent_status == "blocked") | .pane_id' |
    sort)"})
  (( $#ids )) || return 0

  # 今 focus している pane が候補に含まれるなら、その次から探す
  local cur=$(api pane list | jq -r '.result.panes[] | select(.focused) | .pane_id' | head -n1)
  local -i i=${ids[(Ie)$cur]}
  local -i n=$(( i % $#ids + 1 ))

  api agent focus ${ids[n]} >/dev/null
}

# pane_id はタブ / ワークスペース間の移動で変わるが terminal_id は変わらないので、
# シェルは起動時にこれを覚えておけば以後ずっと自分のタブを引ける
cmd_terminal_id() {
  local pane=$1
  [[ -n $pane ]] || return 1
  api pane get $pane | jq -r '.result.pane.terminal_id // empty'
}

dir_name() {
  (( ${+commands[current_dir]} )) || return 1
  local dir=$1
  [[ -d $dir ]] || return 1
  (cd -- $dir && current_dir) 2>/dev/null
}

cmd_rename_tab_name() {
  local tid=$1
  [[ -n $tid ]] || return 1

  local tab ws cwd
  IFS=$'\x1f' read -r tab ws cwd <<<"$(api pane list |
    jq -r --arg t $tid '(.result.panes[] | select(.terminal_id == $t)) | [.tab_id, .workspace_id, .cwd] | join("\u001f")' |
    head -n1)"
  [[ -n $tab ]] || return 1

  # プールのタブは表に出ないので触らない
  local label=$(api workspace list |
    jq -r --arg w $ws '.result.workspaces[] | select(.workspace_id == $w) | .label')
  [[ $label == $pool_label ]] && return 0

  local name=$(dir_name $cwd) || return 0
  [[ -n $name ]] || return 0
  api tab rename $tab $name >/dev/null
}

# 区切りをUnit Separator (0x1f)にすることで、空白の連続に対応
space_rows() {
  api api snapshot | jq -r --arg t $space_token '
    .result.snapshot as $s
    | $s.workspaces[]
    | . as $w
    | ($s.layouts[] | select(.tab_id == $w.active_tab_id) | .focused_pane_id) as $pane
    | (($s.panes[] | select(.pane_id == $pane) | .cwd) // "") as $cwd
    | [$w.workspace_id, $w.label, ($w.tokens[$t] // ""), $cwd]
    | join("\u001f")'
}

cmd_rename_space_names() {
  local row ws label cur cwd name
  for row in ${(f)"$(space_rows)"}; do
    IFS=$'\x1f' read -r ws label cur cwd <<<"$row"
    [[ -n $ws ]] || continue

    if [[ $label == $pool_label ]]; then
      name=_
    elif [[ $label == $misc_label ]]; then
      # _misc はそのまま
      name=$label
    else
      name=$(dir_name $cwd) || continue
    fi
    # 差分がないときはcontinue
    [[ -n $name && $name != $cur ]] || continue
    api workspace report-metadata $ws --source $plugin --token $space_token=$name >/dev/null
  done
}

case ${1:-} in
  pick-workspace) open_picker focus-picker ;;
  move-pane) cmd_move_pane ;;
  focus-picker) cmd_focus_picker ;;
  move-picker) cmd_move_picker ;;
  misc) cmd_misc ;;
  move-tab) cmd_move_tab ${2:-next} ;;
  join-tab) cmd_join_tab ${2:-next} ;;
  move-ws) cmd_move_ws ${2:-next} ;;
  select-tab) cmd_select_tab ${2:-0} ;;
  select-ws) cmd_select_ws ${2:-0} ;;
  jump-blocked) cmd_jump_blocked ;;
  terminal-id) cmd_terminal_id ${2:-} ;;
  rename-tab-name) cmd_rename_tab_name ${2:-} ;;
  rename-space-names) cmd_rename_space_names ;;
  *)
    print -ru2 -- "usage: ws.zsh {pick-workspace|move-pane|focus-picker|move-picker|misc|move-tab next|prev|join-tab next|prev|move-ws next|prev|select-tab <n>|select-ws <n>|jump-blocked|terminal-id <pane>|rename-tab-name <tid>|rename-space-names}"
    exit 2
    ;;
esac
exit 0
