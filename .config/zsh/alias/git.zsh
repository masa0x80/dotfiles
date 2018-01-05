# MEMO: This file is based on https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
alias g='git'

alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch --remote'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gco='git checkout'
alias gcp='git cherry-pick'

alias gd='git diff'
alias gdc='git diff --cached'
alias gds='git diff --staged'

alias gf='git fetch'

alias gfx='git fixup'

alias gl='git fzf show'
alias lg='git fzf show'
alias glg='git log --stat --color'
alias glgp='git log --stat --color -p'
alias glog='git log --oneline --decorate --color --graph'

alias gm='git merge --no-ff'

alias gp='git push'
alias gpull='git_pull_and_prune'
alias gpush='git push origin $(git_current_branch)'
alias gpush!='git push --force-with-lease origin $(git_current_branch)'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'

alias gre='git review'

alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'

alias gru='git reset --'

alias gsh='git show'
alias gst='git status -sb'
alias gts='git tag -s'

# ref: bin/git-fzf
alias -g GH='$(git fzf)'
