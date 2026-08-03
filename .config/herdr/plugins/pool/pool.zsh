#!/bin/zsh -f
# herdr session pool
#
# `_pool` ワークスペースで起動しておいた zsh プロセスを使うことで pane の作成を高速化する。
#
#   pool.zsh ensure              プールを作成 / 補充する
#   pool.zsh new-tab [after|before]
#                                プールから 1 枚取り出して現在のタブの右 / 左に足す
#   pool.zsh split right|down    プールから 1 枚取り出して現在のペインを分割する
#   pool.zsh sync [path]         プールのカレントディレクトリーを path に揃える
#   pool.zsh focus-sync          pane.focused イベント用の sync

emulate -L zsh
setopt no_nomatch

# herdr サーバーの環境は対話シェルとは限らないので、最低限の PATH を補う
# （タブ名に使う current_dir が ~/.bin にあるので、そこも通す）
path=(
  /etc/profiles/per-user/$USER/bin(N-/)
  /run/current-system/sw/bin(N-/)
  /nix/var/nix/profiles/default/bin(N-/)
  /opt/homebrew/bin(N-/)
  $HOME/.bin.local(N-/)
  $HOME/.bin(N-/)
  $path
)

local herdr=${HERDR_BIN_PATH:-herdr}
local socket=${HERDR_SOCKET_PATH:-${XDG_CONFIG_HOME:-$HOME/.config}/herdr/herdr.sock}
local label=${HERDR_POOL_LABEL:-_pool}
# 2 以上にしておくと、1 枚取り出してもプールのワークスペースが空にならず、
# サイドバーから消えて再作成される瞬きが起きない
local -i size=${HERDR_POOL_SIZE:-2}
# HERDR_PLUGIN_STATE_DIR はプラグイン経由の起動でしか渡ってこないので、
# zsh の chpwd フックから直接叩かれたときは herdr-plugin.toml の id から組む
local state_dir=${HERDR_PLUGIN_STATE_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/herdr/plugins/zsh-session-pool}
local cwd_file=$state_dir/cwd

(( ${+commands[jq]} )) || exit 0

api() { $herdr "$@" 2>/dev/null }

# tab.move は CLI に出ていないので、ソケットへ直接投げる
raw() {
  local method=$1 params=$2 fd line
  zmodload zsh/net/socket 2>/dev/null || return 1
  zsocket $socket 2>/dev/null || return 1
  fd=$REPLY
  print -u $fd -r -- "{\"id\":\"pool.zsh\",\"method\":\"$method\",\"params\":$params}"
  read -u $fd -r line
  exec {fd}>&-
  print -r -- $line
}

# タブ名は prompt.zsh の _set_window_name と同じ current_dir を使う
tab_name() {
  (( ${+commands[current_dir]} )) || return 1
  local dir=$1
  [[ -d $dir ]] || return 1
  (cd -- $dir && current_dir) 2>/dev/null
}

rename_tab() {
  local tab=$1 name
  [[ -n $tab ]] || return 0
  name=$(tab_name $2) || return 0
  [[ -n $name ]] || return 0
  api tab rename $tab $name >/dev/null
}

# HERDR_PLUGIN_CONTEXT_JSON / HERDR_PLUGIN_EVENT_JSON から 1 フィールド取り出す
ctx() { print -r -- ${HERDR_PLUGIN_CONTEXT_JSON:-'{}'} | jq -r "$1 // empty" }
event() { print -r -- ${HERDR_PLUGIN_EVENT_JSON:-'{}'} | jq -r "$1 // empty" }

pool_ws() {
  api workspace list |
    jq -r --arg l $label '.result.workspaces[] | select(.label == $l) | .workspace_id' |
    head -n1
}

pool_panes() {
  api pane list --workspace $1 | jq -r '.result.panes[].pane_id'
}

# プールから取り出す 1 枚。"<pane_id>\t<cwd>" を返す
pool_take() {
  local ws=$1
  api pane list --workspace $ws |
    jq -r '(.result.panes[0] // empty) | "\(.pane_id)\t\(.cwd)"'
}

# 新しいペインを開くときの基準ディレクトリー
target_cwd() {
  local c=$(ctx '.focused_pane_cwd')
  [[ -n $c ]] || c=$(api pane current --current | jq -r '.result.pane.cwd // empty')
  [[ -n $c && -d $c ]] || c=$HOME
  print -r -- $c
}

# プールから持ってきたペインを目的のディレクトリーに合わせる。
# sync 済みなら何も送らないので、実際にはほとんど no-op になる。
settle() {
  local pane=$1 from=$2 to=$3
  [[ -n $pane && -n $to && $from != $to ]] || return 0
  api pane run $pane " cd -- ${(q)to} && clear" >/dev/null
}

last_cwd() { [[ -r $cwd_file ]] && print -r -- "$(<$cwd_file)" }

ensure() {
  # イベントは並行して飛んでくるので、補充は 1 プロセスだけに任せる
  local lock=$state_dir/ensure.lock
  mkdir -p $state_dir
  local -a stale=($lock(N/mm+1))
  (( $#stale )) && rmdir $lock 2>/dev/null
  mkdir $lock 2>/dev/null || return 0
  trap "rmdir ${(q)lock} 2>/dev/null" EXIT

  local ws cwd
  cwd=$(last_cwd)
  [[ -n $cwd && -d $cwd ]] || cwd=$(target_cwd)

  ws=$(pool_ws)

  if [[ -z $ws ]]; then
    ws=$(api workspace create --label $label --cwd $cwd --no-focus |
      jq -r '.result.workspace.workspace_id // empty')
    [[ -n $ws ]] || return 1
  fi

  # _pool は常に先頭に固定する（workspace.move も CLI には無いのでソケット直叩き）
  local -a ids=(${(f)"$(api workspace list | jq -r '.result.workspaces[].workspace_id')"})
  local -i i=${ids[(Ie)$ws]}
  (( i > 1 )) && raw workspace.move "{\"workspace_id\":\"$ws\",\"insert_index\":0}" >/dev/null

  local -i n=$(pool_panes $ws | grep -c .)
  while (( n < size )); do
    api tab create --workspace $ws --cwd $cwd --no-focus >/dev/null || break
    (( n++ ))
  done
}

# 末尾に作られた新しいタブを、現在のタブの直前 / 直後へ動かす
move_new_tab() {
  local tab=$1 where=$2 cur=${HERDR_TAB_ID:-}
  [[ -n $tab && -n $cur && $tab != $cur ]] || return 0
  local -a scope=()
  [[ -n ${HERDR_WORKSPACE_ID:-} ]] && scope=(--workspace $HERDR_WORKSPACE_ID)
  local -a ids=(${(f)"$(api tab list $scope | jq -r '.result.tabs[].tab_id')"})
  local -i i=${ids[(Ie)$cur]}
  (( i )) || return 0

  # insert_index は「元の並びでその位置にある要素の手前へ差し込む」意味。
  # 現在のタブの位置を指せば直前、その次を指せば直後に入る（0 起点）
  local -i n
  if [[ $where == before ]]; then
    (( n = i - 1 ))
  else
    (( n = i ))
  fi
  # 指した先が新タブ自身なら既に目的の位置にいる
  [[ ${ids[n+1]} == $tab ]] && return 0
  raw tab.move "{\"tab_id\":\"$tab\",\"insert_index\":$n}" >/dev/null
}

cmd_new_tab() {
  local where=${1:-after}
  local ws=${HERDR_WORKSPACE_ID:-}
  [[ -n $ws ]] || ws=$(api pane current --current | jq -r '.result.pane.workspace_id // empty')
  [[ -n $ws ]] || return 1

  local want=$(target_cwd) pane pane_cwd
  IFS=$'\t' read -r pane pane_cwd <<<"$(pool_take "$(pool_ws)")"

  local new new_tab
  if [[ -n $pane ]]; then
    IFS=$'\t' read -r new new_tab <<<"$(api pane move $pane --new-tab --workspace $ws --focus |
      jq -r '(.result.move_result // empty) | "\(.pane.pane_id)\t\(.created_tab.tab_id // .pane.tab_id)"')"
    settle "$new" "$pane_cwd" "$want"
  fi
  # プールが空だった / 取り出しに失敗したときは素直に新しいシェルを起動する
  if [[ -z $new ]]; then
    new_tab=$(api tab create --workspace $ws --cwd $want --focus |
      jq -r '.result.tab.tab_id // empty')
  fi

  move_new_tab "$new_tab" "$where"
  rename_tab "$new_tab" "$want"

  ensure
}

cmd_split() {
  local dir=$1
  local tab=${HERDR_TAB_ID:-} cur=${HERDR_PANE_ID:-}
  local want=$(target_cwd) pane pane_cwd new
  local -a target=() from=()
  [[ -n $cur ]] && target=(--target-pane $cur) from=(--pane $cur)
  IFS=$'\t' read -r pane pane_cwd <<<"$(pool_take "$(pool_ws)")"

  if [[ -n $pane && -n $tab ]]; then
    new=$(api pane move $pane --tab $tab --split $dir $target --focus |
      jq -r '.result.move_result.pane.pane_id // empty')
    settle "$new" "$pane_cwd" "$want"
  fi
  [[ -n $new ]] || api pane split $from --direction $dir --cwd $want --focus >/dev/null

  ensure
}

# プール側のシェルを先回りで cd させておく。
# cwd_file を先に書くので、送り込んだ cd が pool 側の chpwd フックを
# 再び呼んでも 2 周目は打ち切られる。
cmd_sync() {
  local want=${1:-}
  [[ -n $want ]] || want=$(target_cwd)
  [[ -d $want ]] || return 0
  [[ $want != "$(last_cwd)" ]] || return 0

  local ws=$(pool_ws)
  [[ -n $ws ]] || return 0

  mkdir -p $state_dir
  print -r -- $want >$cwd_file

  # _herdr_quiet を立てている間だけ zsh 側のフックを黙らせる
  # （プールへの cd がプール同期やタブ名変更を呼び返さないように）
  local pane
  for pane in ${(f)"$(pool_panes $ws)"}; do
    api pane run $pane " _herdr_quiet=1; cd -- ${(q)want}; _herdr_quiet=; clear" >/dev/null
  done
}

case ${1:-} in
  ensure)
    # プール自身の作成イベントで呼び戻されたときは何もしない
    [[ $(event '.data.workspace.label') == $label ]] || ensure
    ;;
  new-tab) cmd_new_tab ${2:-after} ;;
  new-tab-before) cmd_new_tab before ;;
  split) cmd_split ${2:-right} ;;
  split-right) cmd_split right ;;
  split-down) cmd_split down ;;
  sync) cmd_sync ${2:-} ;;
  focus-sync)
    # プール自身のフォーカスでは何もしない
    local ws_label pane_cwd
    IFS=$'\t' read -r ws_label pane_cwd <<<"$(
      print -r -- ${HERDR_PLUGIN_CONTEXT_JSON:-'{}'} |
        jq -r '"\(.workspace_label // "")\t\(.focused_pane_cwd // "")"'
    )"
    ;;
  *)
    print -ru2 -- "usage: pool.zsh {ensure|new-tab [before]|new-tab-before|split-right|split-down|sync [path]|focus-sync}"
    exit 2
    ;;
esac
exit 0
