# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export UNAME_S=(uname -s | tr '[:upper:]' '[:lower:]')

# Global Environment Variables {{{

# load proxy settings
[ -r $HOME/.proxy ] && source $HOME/.proxy

# PATH
set -gx PATH /usr/local/bin /bin /usr/bin /sbin /usr/sbin

export SHELL=(which fish)

# anyenv settings
if test -d $HOME/.anyenv
    set -gx fish_user_paths $fish_user_paths $HOME/.anyenv/bin
end
if type -qa anyenv && status --is-interactive
    source (anyenv init - | psub)
end

# golang
[ $UNAME_S = 'linux' ] && set -gx fish_user_paths $fish_user_paths /usr/local/go/bin
export GOPATH=$HOME/.go
set -gx fish_user_paths $fish_user_paths $GOPATH/bin

# rust
[ -d $HOME/.cargo ] && set -gx fish_user_paths $fish_user_paths $HOME/.cargo/bin

# lang
export LANG=ja_JP.UTF-8

# venv
export VIRTUAL_ENV_DISABLE_PROMPT=disabled
set VENV_PATH $XDG_DATA_HOME/venv/python3
if test ! -d $VENV_PATH
    python3 -m venv $VENV_PATH
    source $VENV_PATH/bin/activate
    pip install -r $HOME/.config/pip/global-requirements
    deactivate
end

# sshrc config
export SSHHOME=$XDG_CONFIG_HOME/sshrc

# gtags (GNU Global)
export GTAGSLABEL=pygments

export TERM=xterm-256color

export LESS='-RIXc'

# fzf options
export FZF_DEFAULT_OPTS='--reverse --no-sort --extended --ansi --multi --cycle --bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-z:toggle-all'

switch $UNAME_S
    case darwin
        # Disable homebrew analytics
        export HOMEBREW_NO_ANALYTICS=1
    case linux
        # gtags (GNU Global)
        export GTAGSCONF=/usr/local/share/gtags/gtags.conf
end

# EDITOR
if type -qa nvim
    export EDITOR=nvim
else if type -qa vim
    export EDITOR=vim
end

# PAGER
if type -qa less
    export PAGER=less
end

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

# }}}

# Environment Variables for fish {{{

# Disable greeting
set fish_greeting
set fish_prompt_pwd_dir_length 0

# Colors {{{
set fish_pager_color_completion grey
export fish_color_command=cyan
# }}}

# Set fresco config
type -qa ghq && set -U fresco_root (ghq root)
set -U fresco_plugin_list_path $HOME/.config/fish/plugins.fish

# Set config path for gabbr
export gabbr_config=$HOME/.config/fish/gabbr.conf

# }}}

# venv (global config)
source $XDG_DATA_HOME/venv/python3/bin/activate.fish
