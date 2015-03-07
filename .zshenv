# path
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:$HOME/bin

# pyenv
export PATH=$HOME/.pyenv/bin:$PATH
if type pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
if type rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# editor
export EDITOR=vim

# term color
export TERM=xterm-256color

# 環境ローカルの設定の読み込み
test -r $HOME/.zshenv.local && source $HOME/.zshenv.local
