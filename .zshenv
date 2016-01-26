# path
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:$HOME/bin

# anyenv
export PATH=$HOME/.anyenv/bin:$PATH
if type anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# editor
export EDITOR=vim

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config

# term color
export TERM=xterm-256color

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

# fzf
export FZF_DEFAULT_OPTS='--extended --ansi --multi --cycle --bind=ctrl-u:page-up --bind=ctrl-d:page-down --bind=ctrl-z:toggle-all'

# load proxy settings
test -r $HOME/.proxy && source $HOME/.proxy

# 環境ローカルの設定の読み込み
test -r $HOME/.zshenv.local && source $HOME/.zshenv.local
