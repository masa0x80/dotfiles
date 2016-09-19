# profiling start
# zmodload zsh/zprof

load_file() { test -r $1 && . $1 }

# load useful functions
load_file $HOME/.zsh/util.zsh

fpath=(/usr/local/share/zsh-completions(N-/) $fpath)

# lang
export LANG=ja_JP.UTF-8

# term color
export TERM=xterm-256color

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

# gtags (GNU Global)
export GTAGSLABEL=pygments

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

export USE_ASSH=true

# zplug
export ZPLUG_HOME=$HOME/.zplug

# OSごとの設定の読み込み
for config_file ($HOME/.zsh/os/$(uname | tr '[:upper:]' '[:lower:]')/profile/*.zsh(N)); do
  load_file $config_file
done

# 環境ローカルの設定の読み込み
load_file $HOME/.local_config/zsh/profile

# Append $DOTFILE/bin to $PATH
export DOTFILE=${DOTFILE:-$HOME/.dotfiles}
export PATH=$PATH:$DOTFILE/bin
