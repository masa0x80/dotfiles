# profiling start
# zmodload zsh/zprof

load_file() { test -r $1 && . $1 }

# load useful functions
load_file $XDG_CONFIG_HOME/zsh/util.zsh

fpath=(/usr/local/share/zsh-completions(N-/) $fpath)

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

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

# zplug
export ZPLUG_HOME=$HOME/.zplug

# OSごとの設定の読み込み
for config_file ($XDG_CONFIG_HOME/zsh/os/$(uname | tr '[:upper:]' '[:lower:]')/profile/*.zsh(N)); do
  load_file $config_file
done

# gcloud設定の読み込み
load_file $HOME/google-cloud-sdk/path.zsh.inc

# 環境ローカルの設定の読み込み
load_file $HOME/.config.local/zsh/profile

# Append $DOTFILE/bin to $PATH
export DOTFILE=${DOTFILE:-$HOME/.dotfiles}
export PATH=$PATH:$DOTFILE/bin

source $XDG_DATA_HOME/venv/python3/bin/activate
