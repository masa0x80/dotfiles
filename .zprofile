# profiling start
# zmodload zsh/zprof

load_file() { test -r $1 && source $1 }

fpath=(/usr/local/share/zsh-completions(N-/) $fpath)

# lang
export LANG=ja_JP.UTF-8

# path
export PATH=/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/sbin:$HOME/bin

# anyenv
export PATH=$HOME/.anyenv/bin:$PATH
if (( $+commands[anyenv] )); then
  eval "$(anyenv init -)"
fi

# editor
if (( $+commands[nvim] )); then
  export EDITOR=nvim
elif (( $+commands[vim] )); then
  export EDITOR=vim
fi

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
export FZF_DEFAULT_OPTS='
--reverse
--extended
--ansi
--multi
--cycle
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
--color dark,hl:33,hl+:37,fg+:235,bg+:234,fg+:254
--color info:254,prompt:37,spinner:108,pointer:168,marker:168
'

# OSごとの設定の読み込み
for config_file ($HOME/.zsh/os/$(uname | tr A-Z a-z)/profile/*.zsh(N)); do
  load_file $config_file
done

# load proxy settings
load_file $HOME/.proxy

# 環境ローカルの設定の読み込み
load_file $HOME/.private/zsh/profile
