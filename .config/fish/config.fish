### Environment Variables
# {{{

# Disable greeting
set fish_greeting

# OSTYPE
set -gx OS_TYPE (uname | tr '[:upper:]' '[:lower:]')

# LANG
set -gx LANG ja_JP.UTF-8

# PATH
set -gx PATH /usr/local/bin /bin /usr/bin /sbin /usr/sbin
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
  set -gx EDITOR nvim
else if type -qa vim
  set -gx EDITOR vim
end

# PAGER
if type -qa less
  set -gx PAGER less
end
set -gx LESS '-R'

# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME $HOME/.config

# TERM
set -gx TERM xterm-256color

# golang
if string match -q $OS_TYPE 'linux'
  set PATH $PATH /usr/local/go/bin
end
set -gx GOPATH $HOME/.go
set PATH $PATH $GOPATH/bin

# gtags (GNU Global)
set -gx GTAGSLABEL pygments

# rails (for rails server alias)
set -gx RAILS_SERVER_PORT 3000

# Use assh flag
set -gx USE_ASSH true

# fzf options
set -gx FZF_DEFAULT_OPTS '
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
set -gx HOMEBREW_NO_ANALYTICS 1

# Load OS settings
for config_file in $HOME/.config/fish/conf.d/$OS_TYPE/*
  source $config_file
end

# load proxy settings if exists
load_file $HOME/.proxy

# load private configurations
load_file $HOME/.private/fish/config.fish

# Append $DOTPATH/bin to $PATH
set -q $DOTPATH; and set -gx DOTPATH $HOME/.dotfiles
set PATH $PATH $DOTPATH/bin

# }}}

### prompt
# {{{

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

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

# if type -qa gls
#   alias ls 'gls --color=auto'
# else
#   alias ls 'ls --color=auto'
# end
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

if test -e $HOME/.ssh/config
  alias sshconfig 'vim ~/.ssh/config'
end
alias sconfig sshconfig
alias sconf   sshconfig

# }}}

### Aliases for rails
# {{{

function s
  set -l t_window    (tmux list-windows | command grep -E '\(active\)$' | cut -d ':' -f1)
  set -l t_pane      (tmux list-pane    | command grep -E '\(active\)$' | cut -d ':' -f1)
  set -l window_name (tmux display -p '#{window_name}')
  tmux rename-window $window_name/server
  tmux split-window -t ":$t_window.$t_pane" -v -p 10 "tmux select-pane -t :.-; rails s -p $RAILS_SERVER_PORT"
end

function bundle
  set -l  t_window (tmux list-windows | command grep -E '\(active\)$' | cut -d ':' -f1)
  set -l t_pane    (tmux list-pane    | command grep -E '\(active\)$' | cut -d ':' -f1)
  command bundle $argv
  if string match -q $argv[1] 'install'
    if type -qa gtags; and type -qa cpulimit; and type -qa tmux
      set -l pid %self
      set -l log_file /tmp/gtags-$pid
      echo
      set_color magenta;
      echo gtags error log: $log_file
      echo
      tmux split-window -t ":$t_window.$t_pane" -v -l 1 "tmux select-pane -t :.-; cpulimit -i -l 30 gtags -v 2>&1 | tee $log_file"
    end
  end
end

alias ss "pkill -f 'bin/rails'; pkill -f 'bin/spring'"
alias c  'rails c'
alias db 'rails db'
alias t  'rspec'
alias bi  'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4'
alias bil 'bi --local'

# }}}

### direnv
# {{{

if type -qa direnv
  eval (direnv hook fish)
end

alias direnv-init 'echo \'export PATH=$PWD/bin:$PWD/vendor/bin:$PATH\' > .envrc; and direnv allow'

# }}}

### Scrapbook
# {{{

if type -qa fzf; and type -qa mdv; and test -e $SCRAPBOOK_DIR
  function scrapbook
    set -q $SCRAPBOOK_DIR; and set -gx SCRAPBOOK_DIR $HOME/.scrapbook
    find $SCRAPBOOK_DIR -type f | fzf --query "$argv" | read -l selected_line
    if not set -q $selected_line
      mdv $selected_line
    end
    commandline -f repaint
  end
end

# }}}

### keychain
# {{{

start_keychain
trap 'kill_keychain' EXIT

# }}}

### tmux
# {{{

tmux_attach_session

# }}}
