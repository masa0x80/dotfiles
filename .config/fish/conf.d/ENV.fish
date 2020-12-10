# Set SHELL variable
export SHELL=(type -p fish)
export TERM=xterm-256color

# Skip loading config if already login
status is-login || exit

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# PATH {{{

# golang
export GO111MODULE=on
export GOPATH=$HOME/go

# golang
if type -qa go
    set -p PATH $GOPATH/bin
end

# rust
if test -d $HOME/.cargo
    set -p PATH $HOME/.cargo/bin
end

# asdf
source (brew --prefix asdf)/asdf.fish
export NODEJS_CHECK_SIGNATURES=no

# masa0x80/git_checkout_keybind.fish
set -U SELECT_BRANCH_KEYBIND '\cgb'

# brew install curl
__add_fish_user_paths /usr/local/opt/curl/bin

# brew install ncurses
__add_fish_user_paths /usr/local/opt/ncurses/bin

# brew install openssl
__add_fish_user_paths /usr/local/opt/openssl/bin

# brew install sqlite
__add_fish_user_paths /usr/local/opt/sqlite/bin

# brew install gettext
__add_fish_user_paths /usr/local/opt/gettext/bin

# brew install gnu-getopt
__add_fish_user_paths /usr/local/opt/gnu-getopt/bin

# brew install coreutils
__add_fish_user_paths /usr/local/opt/coreutils/libexec/gnubin

# brew install gnu-sed
__add_fish_user_paths /usr/local/opt/gnu-sed/libexec/gnubin

# brew install gnu-tar
__add_fish_user_paths /usr/local/opt/gnu-tar/libexec/gnubin

# brew install grep
__add_fish_user_paths /usr/local/opt/grep/libexec/gnubin

# PATH }}}

export UNAME_S=(uname -s | tr '[:upper:]' '[:lower:]')
# Disable homebrew analytics
test "$UNAME_S" = 'darwin' && export HOMEBREW_NO_ANALYTICS=1

# load proxy settings
__load_file $HOME/.proxy

export LANG=en_US.UTF-8

# EDITOR
if type -qa nvim
    # export EDITOR=nvim
    export EDITOR=vim
else if type -qa vim
    export EDITOR=vim
end

# PAGER
export LESS='-RIXc'
type -qa less && export PAGER='less'
# ref. http://www.tuxarena.com/2012/04/tutorial-colored-man-pages-how-it-works/
export LESS_TERMCAP_mb=(printf '\e[01;31m') # enter blinking mode – red
export LESS_TERMCAP_md=(printf '\e[01;33m') # enter double-bright mode – bold, yellow
export LESS_TERMCAP_me=(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=(printf '\e[01;32m') # enter standout mode – green
export LESS_TERMCAP_ue=(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=(printf '\e[04;34m') # enter underline mode – cyan

# brew install openssl
test -d /usr/local/opt/openssl/bin && set -gxa LIBRARY_PATH /usr/local/opt/openssl/lib/

# fzf options
type -qa fd && export FZF_DEFAULT_COMMAND='fd --type f --no-ignore --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--reverse --extended --ansi --multi --cycle --bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-z:toggle-all'

# NOTE: dynamic library support
#       ref https://github.com/nixprime/cpsm
export PYTHON_CONFIGURE_OPTS='--enable-framework'

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

# Disable greeting
set -gx fish_greeting
set -gx fish_prompt_pwd_dir_length 0

# Colors {{{
set -gx fish_pager_color_completion grey
export fish_color_command=cyan
# Colors }}}

### Prompt {{{

set -gx __fish_git_prompt_showdirtystate 'yes'
set -gx __fish_git_prompt_showstashstate 'yes'
set -gx __fish_git_prompt_showuntrackedfiles 'yes'
set -gx __fish_git_prompt_showupstream 'yes'

set -gx __fish_git_prompt_color_branch ''
set -gx __fish_git_prompt_color_upstream_ahead ''
set -gx __fish_git_prompt_color_upstream_behind ''

set -gx __fish_git_prompt_char_dirtystate '⨯'
set -gx __fish_git_prompt_char_stagedstate '→'
set -gx __fish_git_prompt_char_untrackedfiles 'u'
set -gx __fish_git_prompt_char_stashstate 's'
set -gx __fish_git_prompt_char_upstream_ahead '+'
set -gx __fish_git_prompt_char_upstream_behind '-'

# Prompt }}}

# Set config path for gabbr
set -gx gabbr_config $HOME/.config/fish/gabbr.conf
