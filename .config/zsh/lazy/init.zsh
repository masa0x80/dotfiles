# 自分以外を読み込む
for f (
  $ZDOTDIR/lazy/*.zsh(N)
) test "$f" = "$0" || source $f
