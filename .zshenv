# path
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:$HOME/bin

# anyenv
export PATH=$HOME/.anyenv/bin:$PATH
if type anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# editor
export EDITOR=vim

# term color
export TERM=xterm-256color

# 環境ローカルの設定の読み込み
test -r $HOME/.zshenv.local && source $HOME/.zshenv.local
