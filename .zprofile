# profiling start
# zmodload zsh/zprof

load_file() { test -r $1 && . $1 }

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

# pager
if (( $+commands[less] )); then
  export PAGER=less
fi
export LESS='-R'

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config

# term color
export TERM=xterm-256color

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# gtags (GNU Global)
export GTAGSLABEL=pygments

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
--color fg:-1,bg:-1,hl:229,fg+:3,bg+:233,hl+:103
--color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

# Disable homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# enhancd
if (( $+commands[fzf] )); then
  export ENHANCD_FILTER=fzf
fi

# zplug
export ZPLUG_HOME=$HOME/.zplug

# OSごとの設定の読み込み
for config_file ($HOME/.zsh/os/$(uname | tr A-Z a-z)/profile/*.zsh(N)); do
  load_file $config_file
done

# load proxy settings
load_file $HOME/.proxy

# 環境ローカルの設定の読み込み
load_file $HOME/.private/zsh/profile

# keychain
load_file $HOME/.zsh/profile/keychain.zsh
