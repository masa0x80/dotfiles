# Load OS settings {{

for config_file in $HOME/.config/fish/conf.d/$UNAME_S/*
    source $config_file
end

# Append $DOTFILE/bin to $PATH
# NOTE: must place before loading `$HOME/.config.local/fish/config.fish`
not set -q DOTFILE && export DOTFILE=$HOME/.dotfiles
if test -d $DOTFILE
    contains $DOTFILE/bin $PATH || set -gx PATH $DOTFILE/bin $PATH
end

type -qa diff-highlight && export GITPAGER='diff-highlight'

# Load local configurations
__load_file $HOME/.config.local/fish/config.fish

## }}

### Abbreviations {{{

type -qa open && abbr -a o 'open'

type -qa mycli && abbr -a mysql 'mycli'

type -qa pgcli && abbr -a psql 'pgcli'

abbr -a tailf 'tail -f'
abbr -a diff 'diff -u'
abbr -a watch 'watch -n 0.5'
abbr -a mkdir 'mkdir -p'

abbr -a md 'mkdir'
abbr -a rd 'rmdir'
abbr -a rf 'rm -rf'

abbr -a vim 'vi'

if type -qa exa
    alias l='exa'
    alias la='exa -la'
    alias ll='exa -l'
    abbr -a tree 'exa -T'
else
    abbr -a l 'ls'
    abbr -a la 'ls -lAh'
    abbr -a ll 'ls -lh'
end

# ssh {{{
if test -e $HOME/.ssh/config
    abbr -a ssh_config 'eval $EDITOR ~/.ssh/config'
    abbr -a sconfig 'eval $EDITOR ~/.ssh/config'
    abbr -a sconf 'eval $EDITOR ~/.ssh/config'
end
# }}}

# git {{{
abbr -a g 'git'

abbr -a ga 'git add'
abbr -a gaa 'git add --all'

abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gbr 'git branch --remote'

abbr -a gc 'git commit -v'
abbr -a gc! 'git commit -v --amend'
abbr -a gcd 'git checkout develop'
abbr -a gcm 'git checkout master'
abbr -a gco 'git checkout'
abbr -a gcp 'git cherry-pick'

abbr -a gsw 'git switch'
abbr -a gsc 'git switch -c'
abbr -a gcb 'git switch -c'
abbr -a gre 'git restore'

abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gds 'git diff --staged'

abbr -a gf 'git fetch'

abbr -a gfx 'git fixup'

abbr -a lg 'git fzf show'

abbr -a gl 'tig'
abbr -a glg 'git log --stat --color'
abbr -a glgp 'git log --stat --color -p'
abbr -a glog 'git log --oneline --decorate --color --graph'

abbr -a gm 'git merge --no-ff'

abbr -a gp 'git push'
abbr -a gpull 'git_pull_and_prune'
abbr -a gpush 'git push origin (git_current_branch)'
abbr -a gpush! 'git push --force-with-lease origin (git_current_branch)'

abbr -a grb 'git rebase'
abbr -a grbm 'git rebase master'

abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase -i'
abbr -a grbs 'git rebase --skip'

abbr -a gri 'git rebase -i (git fzf)'

abbr -a grh 'git reset HEAD'
abbr -a grhh 'git reset HEAD --hard'

abbr -a gru 'git reset --'

abbr -a gsh 'git show'
abbr -a gst 'git status -sb'
abbr -a gts 'git tag -s'

abbr -a review 'git review'
# }}}


# vagrant {{{
abbr -a vdf 'vagrant destroy -f'
abbr -a vst 'vagrant global-status'
# }}}

# ruby {{{
abbr -a r 'rails'

abbr -a c 'rails c'
abbr -a s "rails s -p $RAILS_SERVER_PORT"

abbr -a db 'rails db'
abbr -a rr 'rails routes'

abbr -a t 'rspec'
abbr -a ss 'spring stop'

abbr -a be 'bundle exec'
abbr -a bi 'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4'
abbr -a bil 'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4 --local'
# }}}

# docker {{{
abbr -a dcu 'dc up -d'
abbr -a dcd 'dc down'
# }}}

# }}}

### gabbr
not set -q global_abbreviations && gabbr -r

### Hooks {{{

type -qa direnv && eval (direnv hook fish)

function __prepare_rename_window --on-event fish_preexec
    if __tmux_is_running
        set -gx TMUX_WINDOW_INDEX (tmux display-message -p '#I')
    end
end
function __exec_rename_window --on-event rename_window
    __check_local_git_config
    if __tmux_is_running
        tmux rename-window -t $TMUX_WINDOW_INDEX (current_dir)
    end
end
function __rename_window --on-event fish_prompt
    emit rename_window
end

__prepare_rename_window
emit rename_window

# }}}
