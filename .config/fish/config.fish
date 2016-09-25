# Environment Variables {{{

# Disable greeting
set fish_greeting
set fish_prompt_pwd_dir_length 0

# Colors {{{
set -U color_red     (set_color red)
set -U color_magenta (set_color magenta)
set -U color_yellow  (set_color yellow)
set -U color_green   (set_color green)
set -U color_blue    (set_color blue)
set -U color_cyan    (set_color cyan)
set -U color_white   (set_color white)
set -U color_grey    (set_color grey)
set -U color_black   (set_color black)
set -U color_normal  (set_color normal)
set -U color_success $color_magenta
set -U color_error   (set_color red --bold)

set -U fish_color_command cyan
# }}}

# OSTYPE
set -U OS_TYPE (uname | tr '[:upper:]' '[:lower:]')

# EDITOR
if type -qa nvim
  set -U EDITOR nvim
else if type -qa vim
  set -U EDITOR vim
end

# PAGER
if type -qa less
  set -U PAGER less
end
set -U LESS '-R'

# rails (for rails server alias)
set -U RAILS_SERVER_PORT 3000

# Use assh flag
set -U USE_ASSH true

# Set scrapbook dir path
not set -q SCRAPBOOK_DIR; and set -U SCRAPBOOK_DIR $HOME/.scrapbook

# Load OS settings
for config_file in $HOME/.config/fish/conf.d/$OS_TYPE/*
  source $config_file
end

# load local configurations
__load_file $HOME/.local_config/fish/config.fish

# Append $DOTFILE to $PATH
not set -q DOTFILE; and set -U DOTFILE $HOME/.dotfiles
set PATH $PATH $DOTFILE/bin

# }}}

### Prompt {{{

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

### Abbreviations {{{

abbr -a diff 'diff -u'
abbr -a watch 'watch -n 0.5'
abbr -a grep  'command grep -v grep | command grep  --color=auto'
abbr -a egrep 'command grep -v grep | command egrep --color=auto'
abbr -a mkdir 'mkdir -p'

if type -qa nvim
  abbr -a vim 'nvim'
end

if type -qa htop
  abbr -a top 'htop'
end

abbr -a md 'mkdir'
abbr -a rd 'rmdir'
abbr -a rf 'rm -rf'

abbr -a l  'ls -lah'
abbr -a ll 'ls -lh'
abbr -a la 'ls -lAh'

abbr -a ...    'cd ../..'
abbr -a ....   'cd ../../..'
abbr -a .....  'cd ../../../..'
abbr -a ...... 'cd ../../../../..'

abbr -a dinit 'echo \'export PATH=$PWD/bin:$PWD/vendor/bin:$PATH\' > .envrc; and direnv allow'

# ssh {{{
if test -e $HOME/.ssh/config
  abbr -a ssh_config 'vim ~/.ssh/config'
  abbr -a sconfig    'vim ~/.ssh/config'
  abbr -a sconf      'vim ~/.ssh/config'
end
# }}}

# git {{{
abbr -a g 'git'

abbr -a ga  'git add'
abbr -a gaa 'git add --all'

abbr -a gb  'git branch'
abbr -a gba 'git branch -a'
abbr -a gbr 'git branch --remote'

abbr -a gc  'git commit -v'
abbr -a gc! 'git commit -v --amend'
abbr -a gcb 'git checkout -b'
abbr -a gcm 'git checkout master'
abbr -a gco 'git checkout'
abbr -a gcp 'git cherry-pick'

abbr -a gd  'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gds 'git diff --staged'

abbr -a gf 'git fetch'

abbr -a gfx 'git fixup'

abbr -a gl  'git fzf show'
abbr -a lg  'git fzf show'
abbr -a glg  'git log --stat --color'
abbr -a glgp 'git log --stat --color -p'
abbr -a glog 'git log --oneline --decorate --color --graph'

abbr -a gm 'git merge --no-ff'

abbr -a gp 'git push'
abbr -a gpull 'git_pull_and_prune'
abbr -a gpush  'git push origin (git_current_branch)'
abbr -a gpush! 'git push --force-with-lease origin (git_current_branch)'

abbr -a grb  'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase -i'
abbr -a grbm 'git rebase master'
abbr -a grbs 'git rebase --skip'

abbr -a gre 'git review'

abbr -a grh  'git reset HEAD'
abbr -a grhh 'git reset HEAD --hard'

abbr -a gru 'git reset --'

abbr -a gsh 'git show'
abbr -a gst 'git status -sb'
abbr -a gts 'git tag -s'
# }}}

# knife solo {{{
abbr -a krepare 'knife solo prepare'
abbr -a kook    'knife solo cook'
# }}}

# rails {{{
abbr -a s  "rails s -p $RAILS_SERVER_PORT"
abbr -a c  'rails c'
abbr -a db 'rails db'
abbr -a t  'rspec'
abbr -a ss "pkill -f 'bin/rails'; pkill -f 'bin/spring'"
abbr -a bi  'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4'
abbr -a bil 'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4 --local'
# }}}

# }}}

### Hooks {{{

if type -qa direnv
  eval (direnv hook fish)
end

__keychain_start
trap '__keychain_kill' EXIT

function __rename_window --on-event fish_prompt
  __check_local_git_config
  __tmux_attach_session
  if __tmux_is_running
    __tmux_window_name | read -l window_name
    tmux rename-window "$window_name"
  end
end

function __history_merge --on-event fish_preexec
  history --merge
end

# }}}
