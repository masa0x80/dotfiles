#!/usr/bin/env bash
# git の HEAD が detached のときだけ短いコミットハッシュを出す
# プロンプト表示のたびに実行されるので、判定は bash の組み込みで行い、git は表示するときだけ呼ぶ

# jj repo 内では HEAD が常に detached で、custom.jj が change を出すので何もしない
# git の root はいちばん近い .git にする
gitroot=""
d=$PWD
while [[ -n $d ]]; do
  [[ -d $d/.jj ]] && exit 0
  [[ -z $gitroot && -e $d/.git ]] && gitroot=$d
  d=${d%/*}
done

head=""
if [[ -n $gitroot ]]; then
  # .git がファイルの場合（git worktree や submodule）は gitdir を辿る
  gitdir=$gitroot/.git
  if [[ -f $gitdir ]]; then
    read -r line <"$gitdir"
    gitdir=${line#gitdir: }
    [[ $gitdir == /* ]] || gitdir=$gitroot/$gitdir
  fi
  [[ -r $gitdir/HEAD ]] && read -r head <"$gitdir/HEAD"
fi

if [[ -n $head ]]; then
  [[ $head == ref:* ]] && exit 0
else
  # GIT_DIR 指定などで HEAD を直接読めないときは git に判定させる
  git symbolic-ref -q HEAD >/dev/null 2>&1 && exit 0
fi

git rev-parse --short HEAD 2>/dev/null
