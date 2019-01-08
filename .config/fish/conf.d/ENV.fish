# Global Environment Variables {{{

export UNAME_S=(uname -s | tr '[:upper:]' '[:lower:]')

# NOTE: must place after setting UNAME_S
source $HOME/.common_variables

# NOTE: must place after adding `/usr/local/bin` to PATH
export SHELL=(which fish)

# }}}

# anyenv settings
[ -d $HOME/.anyenv ] && set -gx fish_user_paths $fish_user_paths $HOME/.anyenv/bin
if type -qa anyenv && status is-interactive
    source (anyenv init - | psub)
end

# golang
if test -d $HOME/.go
    export GOPATH=$HOME/.go
    set -gx fish_user_paths $fish_user_paths $GOPATH/bin
    [ $UNAME_S = 'linux' ] && set -gx fish_user_paths $fish_user_paths /usr/local/go/bin
end

# rust
[ -d $HOME/.cargo ] && set -gx fish_user_paths $fish_user_paths $HOME/.cargo/bin

# venv
export VIRTUAL_ENV_DISABLE_PROMPT=disabled
export VENV_PATH=$XDG_DATA_HOME/venv/python3
if test ! -d $VENV_PATH
    python3 -m venv $VENV_PATH
    source $VENV_PATH/bin/activate.fish
    pip install -r $XDG_CONFIG_HOME/pip/global-requirements
else
    source $VENV_PATH/bin/activate.fish
end

# EDITOR
if type -qa nvim
    export EDITOR=nvim
else if type -qa vim
    export EDITOR=vim
end

# PAGER
type -qa less && export PAGER=less

# Environment Variables for fish {{{

# Disable greeting
set fish_greeting
set fish_prompt_pwd_dir_length 0

# Colors {{{
set fish_pager_color_completion grey
export fish_color_command=cyan
# }}}

### Prompt {{{

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

set __fish_git_prompt_char_dirtystate '⨯'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles 'u'
set __fish_git_prompt_char_stashstate 's'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# }}}

# Set fresco config
type -qa ghq && set -U fresco_root (ghq root)
set -U fresco_plugin_list_path $HOME/.config/fish/plugins.fish

# Set config path for gabbr
export gabbr_config=$HOME/.config/fish/gabbr.conf

# }}}
