# Global Environment Variables {{{

# load proxy settings
[ -r $HOME/.proxy ] && source $HOME/.proxy

# PATH
export PATH=/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin

export SHELL=`which zsh`

# anyenv settings
if test -d $HOME/.anyenv; then
  PATH=$HOME/.anyenv/bin:$PATH
fi
if type -a anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# golang
[ $UNAME_S = 'linux' ] && PATH=/usr/local/go/bin:$PATH
export GOPATH=$HOME/.go
PATH=$GOPATH/bin:$PATH

# rust
[ -d $HOME/.cargo ] && PATH=$HOME/.cargo/bin:$PATH

# lang
export LANG=ja_JP.UTF-8

# venv
export VIRTUAL_ENV_DISABLE_PROMPT=disabled
VENV_PATH=$XDG_DATA_HOME/venv/python3
if test ! -d $VENV_PATH; then
  python3 -m venv $VENV_PATH
  source $VENV_PATH/bin/activate
  pip install -r $HOME/.config/pip/global-requirements
  deactivate
fi

# sshrc config
export SSHHOME=$XDG_CONFIG_HOME/sshrc

# gtags (GNU Global)
export GTAGSLABEL=pygments

export TERM=xterm-256color

export LESS='-RIXc'

# fzf options
export FZF_DEFAULT_OPTS='--reverse --no-sort --extended --ansi --multi --cycle --bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-z:toggle-all'

case $UNAME_S in
  darwin)
    # Disable homebrew analytics
    export HOMEBREW_NO_ANALYTICS=1
    ;;
  linux)
    # gtags (GNU Global)
    export GTAGSCONF=/usr/local/share/gtags/gtags.conf
    ;;
esac

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

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

# Append $DOTFILE/bin to $PATH
export DOTFILE=${DOTFILE:-$HOME/.dotfiles}
export PATH=$PATH:$DOTFILE/bin

# }}}

# Configurations for zsh {{{

load_file() { [ -r $1 ] && . $1 }

# load useful functions
load_file $ZDOTDIR/util.zsh

# OSごとの設定の読み込み
for config_file ($ZDOTDIR/os/$UNAME_S/profile/*.zsh(N)); do
  load_file $config_file
done

# gcloud設定の読み込み
load_file $HOME/google-cloud-sdk/path.zsh.inc

# 環境ローカルの設定の読み込み
load_file $HOME/.config.local/zsh/profile

source $XDG_DATA_HOME/venv/python3/bin/activate

# }}}
