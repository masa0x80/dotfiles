# Load OS settings {{

# NOTE: Use preloaded path
set PATH $_PATH

for config_file in $HOME/.config/fish/conf.d/$UNAME_S/*
    source $config_file
end

# Append $DOTFILE/bin to $PATH
# NOTE: must place before loading `$HOME/.config.local/fish/config.fish`
not set -q DOTFILE && export DOTFILE=$HOME/.dotfiles
set -gx PATH $DOTFILE/bin $PATH

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

type -qa htop && abbr -a top 'htop'

abbr -a md 'mkdir'
abbr -a rd 'rmdir'
abbr -a rf 'rm -rf'

abbr -a vim 'vi'

if type -qa exa
    abbr -a l 'exa -la --git'
    abbr -a la 'exa -la --git'
    abbr -a ll 'exa -l --git'
    abbr -a ls 'exa'
    abbr -a tree 'exa -T'
else
    abbr -a l 'ls -lAh'
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
abbr -a gcb 'git checkout -b'
abbr -a gcm 'git checkout master'
abbr -a gco 'git checkout'
abbr -a gcp 'git cherry-pick'

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
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase -i'
abbr -a grbm 'git rebase master'
abbr -a grbs 'git rebase --skip'

abbr -a gri 'git rebase -i (git fzf)'

abbr -a gre 'git review'

abbr -a grh 'git reset HEAD'
abbr -a grhh 'git reset HEAD --hard'

abbr -a gru 'git reset --'

abbr -a gsh 'git show'
abbr -a gst 'git status -sb'
abbr -a gts 'git tag -s'
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

abbr -a b 'bundle'
abbr -a bi 'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4'
abbr -a bil 'bundle install --path=vendor/bundle --binstubs=vendor/bin --jobs=4 --local'
# }}}

# }}}

### Hooks {{{

type -qa direnv && eval (direnv hook fish)

function __rename_window --on-event fish_prompt
    __check_local_git_config
    __tmux_attach_session
    if __tmux_is_running
        tmux rename-window (current_dir project)
    end
end

# }}}
