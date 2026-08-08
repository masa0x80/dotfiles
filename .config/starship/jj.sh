#!/usr/bin/env bash

set -uo pipefail

readonly C_RESET=$'\033[0m'
readonly C_BOOKMARK=$'\033[38;2;166;227;161m'
readonly C_CHANGE=$'\033[38;2;205;214;244m'
readonly C_CONFLICT=$'\033[1;38;2;243;139;168m'
readonly C_ADDED=$'\033[1;38;2;203;166;247m'
readonly C_MODIFIED=$'\033[1;38;2;249;226;175m'
readonly C_DELETED=$'\033[38;2;243;139;168m'
readonly C_RENAMED=$'\033[1;38;2;148;226;213m'
readonly C_CLEAN=$'\033[1;38;2;245;224;220m'

# 区切りを Unit Separator (0x1f) に
read -r -d '' out < <(
  jj log --no-pager -r @ --no-graph -T '
    self.bookmarks().join(", ") ++ "\x1f" ++
    self.change_id().shortest() ++ "\x1f" ++
    description.first_line() ++ "\x1f" ++
    if(self.conflict(), "1", "") ++ "\x1f" ++
    if(self.empty(), "1", "") ++ "\x1f" ++
    self.diff().files().map(|f| f.status()).join(",")
  ' 2>/dev/null
)

IFS=$'\x1f' read -r bookmarks change_id desc conflict empty statuses <<<"$out"

# jj repoでない or jj が失敗した場合は黙って終了
[[ -n ${change_id:-} ]] || exit 0

# gitがrepoを認識できるなら組み込みgitモジュールが反応する
if git rev-parse --is-inside-work-tree &>/dev/null; then
  colocated=1
  # git HEAD がbranchを指しているならbookmark名はgit_branch表示で対応
  if git symbolic-ref -q HEAD &>/dev/null; then
    show_bookmarks=""
  else
    show_bookmarks=1
  fi
else
  colocated=""
  show_bookmarks=1
fi

# bookmarkがあればそれを表示、無ければ «change_id» + 説明文
if [[ -n $bookmarks && -n $show_bookmarks ]]; then
  result="${C_BOOKMARK}$bookmarks${C_RESET}"
elif [[ -n $desc ]]; then
  result="${C_CHANGE}«${change_id}» ${desc}${C_RESET}"
else
  result="${C_CHANGE}«${change_id}»${C_RESET}"
fi

# conflictはgit statusから読み取れないので colocated でも出す
if [[ -n $conflict ]]; then
  result+=" ${C_CONFLICT}✖${conflict}${C_RESET}"
fi

# colocatedでは差分数/clean表示はgit_statusに委ねる
if [[ -z $colocated ]]; then
  if [[ -n $empty ]]; then
    # conflictしている場合はcleanマークは出さない
    [[ -z $conflict ]] && result+=" ${C_CLEAN}✔${C_RESET}"
  else
    # stauts()はadded, modified, removed, renamed, copied を返す
    IFS=',' read -r -a arr <<<"$statuses"
    added=0 modified=0 removed=0 renamed=0
    for s in "${arr[@]}"; do
      case $s in
      added) ((++added)) ;;
      modified) ((++modified)) ;;
      removed) ((++removed)) ;;
      renamed | copied) ((++renamed)) ;; # renameとcopiedはまとめる
      esac
    done

    ((added > 0)) && result+=" ${C_ADDED}…${added}${C_RESET}"
    ((modified > 0)) && result+=" ${C_MODIFIED}✚${modified}${C_RESET}"
    ((removed > 0)) && result+=" ${C_DELETED}✖${removed}${C_RESET}"
    ((renamed > 0)) && result+=" ${C_RENAMED}»${renamed}${C_RESET}"
  fi
fi

printf '%s' "$result"
