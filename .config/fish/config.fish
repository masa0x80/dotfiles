### Environment Variables
# {{{

# Disable greeting
set fish_greeting

# Colors
# {{{
set -x red          (set_color red)
set -x magenta      (set_color magenta)
set -x yellow       (set_color yellow)
set -x green        (set_color green)
set -x blue         (set_color blue)
set -x cyan         (set_color cyan)
set -x white        (set_color white)
set -x grey         (set_color grey)
set -x black        (set_color black)
set -x color_normal (set_color normal)
# }}}

# OSTYPE
set -x OS_TYPE (uname | tr '[:upper:]' '[:lower:]')

# LANG
set -x LANG ja_JP.UTF-8

# PATH
set -x PATH /usr/local/bin /bin /usr/bin /sbin /usr/sbin
if test -d /usr/local/sbin
  set PATH $PATH /usr/local/sbin
end

# anyenv
if test -d $HOME/.anyenv/bin
  set PATH $HOME/.anyenv/bin $PATH
  status --is-interactive; and source (anyenv init - | psub)
end

# EDITOR
if type -qa nvim
  set -x EDITOR nvim
else if type -qa vim
  set -x EDITOR vim
end

# PAGER
if type -qa less
  set -x PAGER less
end
set -x LESS '-R'

# XDG Base Directory Specification
set -x XDG_CONFIG_HOME $HOME/.config

# TERM
set -x TERM xterm-256color

# golang
if string match -q $OS_TYPE 'linux'
  set PATH $PATH /usr/local/go/bin
end
set -x GOPATH $HOME/.go
set PATH $PATH $GOPATH/bin

# gtags (GNU Global)
set -x GTAGSLABEL pygments

# rails (for rails server alias)
set -x RAILS_SERVER_PORT 3000

# Use assh flag
set -x USE_ASSH true

# fzf options
set -x FZF_DEFAULT_OPTS '
--reverse
--extended
--ansi
--multi
--cycle
--bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-z:toggle-all
--color fg:-1,bg:-1,hl:229,fg+:3,bg+:233,hl+:103
--color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

# Load OS settings
for config_file in $HOME/.config/fish/conf.d/$OS_TYPE/*
  source $config_file
end

# load proxy settings if exists
load_file $HOME/.proxy

# load private configurations
load_file $HOME/.private/fish/config.fish

# Append $DOTPATH/bin to $PATH
set -q $DOTPATH; and set -x DOTPATH $HOME/.dotfiles
set PATH $PATH $DOTPATH/bin

# }}}

### prompt
# {{{

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

set __fish_git_prompt_color_branch          yellow
set __fish_git_prompt_color_upstream_ahead  green
set __fish_git_prompt_color_upstream_behind red

set __fish_git_prompt_char_dirtystate '⨯'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles 'u'
set __fish_git_prompt_char_stashstate 's'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# }}}

### Aliases
#{{{

alias diff 'diff -u'
alias watch 'watch -n 0.5'
alias grep  'command grep -v grep | command grep  --color=auto'
alias egrep 'command grep -v grep | command egrep --color=auto'
alias mkdir 'mkdir -p'
alias md 'mkdir'
alias rd 'rmdir'
alias rf 'rm -rf'

alias l  'ls -lah'
alias ll 'ls -lh'
alias la 'ls -lAh'

if type -qa nvim
  alias vim nvim
end

alias ...    'cd ../..'
alias ....   'cd ../../..'
alias .....  'cd ../../../..'
alias ...... 'cd ../../../../..'

if type -qa htop
  alias top htop
end

# ssh
# {{{
if test -e $HOME/.ssh/config
  alias ssh_config 'vim ~/.ssh/config'
end
alias sconfig ssh_config
alias sconf   ssh_config
# }}}

alias direnv_init 'echo \'export PATH=$PWD/bin:$PWD/vendor/bin:$PATH\' > .envrc; and direnv allow'

# knife solo
# {{{
alias krepare 'knife solo prepare'
alias kook    'knife solo cook'
# }}}

# rails
# {{{
alias s  "rails s -p $RAILS_SERVER_PORT"
alias c  'rails c'
alias db 'rails db'
alias t  'rspec'
alias ss "pkill -f 'bin/rails'; pkill -f 'bin/spring'"
alias bi  'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4'
alias bil 'bi --local'
# }}}

# }}}

### direnv
# {{{

if type -qa direnv
  eval (direnv hook fish)
end

# }}}

### keychain
# {{{

keychain_start
trap 'keychain_kill' EXIT

# }}}

### tmux
# {{{

tmux_attach_session

function rename_window --on-event fish_prompt
  check_private_git_config
  if tmux_is_running
    if test -e .git
      pwd | string split -r -m 2 '/' | grep -v '/' | string join '/' | read -l window_name
      tmux rename-window "$window_name"
    end
  end
end

# }}}
