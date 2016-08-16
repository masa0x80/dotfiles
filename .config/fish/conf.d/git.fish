# MEMO: This file is based on https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh

#
# Functions
#

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch
  set -l ref (command git symbolic-ref --quiet HEAD 2> /dev/null)
  if test $status != 0
    test $status -eq 128; and return  # no git repo.
    set ref (command git rev-parse --short HEAD 2> /dev/null); or return
  end
  echo (string replace 'refs/heads/' '' $ref)
end

function git_repo
 test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function git_dirty
  git_repo; and test -n (echo (command git status --porcelain))
end

# function git_ahead
#   not git_repo; and return
#
#   set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" ^/dev/null)
#
#   switch "$commit_count"
#   case ""
#     # no upstream
#   case "0"\t"0"
#     test -n "$none"; and echo "$none"; or echo ""
#   case "*"\t"0"
#     test -n "$behind"; and echo "$behind"; or echo "-"
#   case "0"\t"*"
#     test -n "$ahead"; and echo "$ahead"; or echo "+"
#   case "*"
#     test -n "$diverged"; and echo "$diverged"; or echo "±"
#   end
# end
#
# # The name of the current branch
# # Back-compatibility wrapper for when this function was defined here in
# # the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# # to fix the core -> git plugin dependency.
# function current_branch() {
#   git_current_branch
# }
#
# # Pretty log messages
# function _git_log_prettily
#   if not test -z $argv[1]
#   # if ! [ -z $1 ]; then
#     git log --pretty=$argv[1]
#   end
# end
#
function git-review
  set -l n (git log --pretty=format:"%H %h" | command grep -n $argv[1] | cut -d : -f 1)
  git log --decorate --stat --reverse -p -$n
end

function git-pull-and-prune
  git pull origin (git_current_branch)
  git fetch --prune --tags --all; and git branch --merged | command egrep -v '^\*|\smaster$|\sdevelop$' | xargs git branch -d
end

#
# Aliases
# (sorted alphabetically)
#

alias g git

alias ga   'git add'
alias gaa  'git add --all'
alias gapa 'git add --patch'

alias gb   'git branch'
alias gba  'git branch -a'
# alias gbda 'git branch --merged | command grep -vE "^(\*|\s*master\s*$)" | command xargs -n 1 git branch -d'
alias gbl  'git blame -b -w'
alias gbnm 'git branch --no-merged'
alias gbr  'git branch --remote'
alias gbs  'git bisect'
alias gbsb 'git bisect bad'
alias gbsg 'git bisect good'
alias gbsr 'git bisect reset'
alias gbss 'git bisect start'

alias gc        'git commit -v'
alias gc!       'git commit -v --amend'
alias gca       'git commit -v -a'
alias gca!      'git commit -v -a --amend'
alias gcan!     'git commit -v -a -s --no-edit --amend'
alias gcam      'git commit -a -m'
alias gcb       'git checkout -b'
alias gcf       'git config --list'
alias gcl       'git clone --recursive'
alias gclean    'git clean -fd'
alias gpristine 'git reset --hard; and git clean -dfx'
alias gcm       'git checkout master'
alias gcmsg     'git commit -m'
alias gco       'git checkout'
alias gcount    'git shortlog -sn'
alias gcp       'git cherry-pick'
alias gcs       'git commit -S'

alias gd   'git diff'
alias gdc  'git diff --cached'
alias gdct 'git describe --tags `git rev-list --tags --max-count=1`'
alias gdt  'git diff-tree --no-commit-id --name-only -r'
# gdv() { git diff -w "$@" | view - }
alias gdw  'git diff --word-diff'

alias gf  'git fetch'
alias gfa 'git fetch --all --prune'
# function gfg() { git ls-files | grep $@ }
alias gfo 'git fetch origin'

# alias gg='git gui citool'
# alias gga='git gui citool --amend'
# ggf() {
# [[ "$#" != 1 ]] && local b="$(git_current_branch)"
# git push --force origin "${b:=$1}"
# }
# compdef _git ggf=git-checkout
# ggl() {
# if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
# git pull origin "${*}"
# else
# [[ "$#" == 0 ]] && local b="$(git_current_branch)"
# git pull origin "${b:=$1}"
# fi
# }
# compdef _git ggl=git-checkout
# # alias ggpull='git pull origin $(git_current_branch)'
# # compdef _git ggpull=git-checkout
alias ggpull 'git-pull-and-prune'
# ggp() {
# if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
# git push origin "${*}"
# else
# [[ "$#" == 0 ]] && local b="$(git_current_branch)"
# git push origin "${b:=$1}"
# fi
# }
# compdef _git ggp=git-checkout
alias ggpush  'git push origin (git_current_branch)'
alias ggpush! 'git push --force-with-lease origin (git_current_branch)'
# compdef _git ggpush=git-checkout
# ggpnp() {
# if [[ "$#" == 0 ]]; then
# ggl && ggp
# else
# ggl "${*}" && ggp "${*}"
# fi
# }
# compdef _git ggpnp=git-checkout
# alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
# ggu() {
# [[ "$#" != 1 ]] && local b="$(git_current_branch)"
# git pull --rebase origin "${b:=$1}"
# }
# compdef _git ggu=git-checkout
# alias ggpur='ggu'
# compdef _git ggpur=git-checkout
#
# alias gignore='git update-index --assume-unchanged'
# alias gignored='git ls-files -v | grep "^[[:lower:]]"'
# alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
# compdef git-svn-dcommit-push=git
#
# alias gk='\gitk --all --branches'
# compdef _git gk='gitk'
# alias gke='\gitk --all $(git log -g --pretty=format:%h)'
# compdef _git gke='gitk'
#
alias gl 'git pull'
alias glg   'git log --stat --color'
alias glgp  'git log --stat --color -p'
alias glgg  'git log --graph --color'
alias glgga 'git log --graph --decorate --all'
alias glgm  'git log --graph --max-count=10'
alias glo   'git log --oneline --decorate --color'
alias glol  "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias glog  'git log --oneline --decorate --color --graph'
# alias glp="_git_log_prettily"
# compdef _git glp=git-log
#
alias gm 'git merge'
# alias gmom='git merge origin/master'
# alias gmt='git mergetool --no-prompt'
# alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
# alias gmum='git merge upstream/master'
#
alias gp    'git push'
alias gpd   'git push --dry-run'
alias gpoat 'git push origin --all; and git push origin --tags'
# compdef _git gpoat=git-push
alias gpu   'git push upstream'
alias gpv   'git push -v'

alias gr  'git remote'
alias gra 'git remote add'
alias grb  'git rebase'
alias grba 'git rebase --abort'
alias grbc 'git rebase --continue'
alias grbi 'git rebase -i'
alias grbm 'git rebase master'
alias grbs 'git rebase --skip'
alias gre 'git-review'
alias grh  'git reset HEAD'
alias grhh 'git reset HEAD --hard'
alias grmv 'git remote rename'
alias grrm 'git remote remove'
alias grset 'git remote set-url'
alias gru 'git reset --'
alias grup 'git remote update'
alias grv 'git remote -v'

alias gsb 'git status -sb'
alias gsi 'git submodule init'
alias gsh  'git show'
alias gsps 'git show --pretty=short --show-signature'
alias gss 'git status -s'
alias gst 'git status'
alias gsta  'git stash'
alias gstaa 'git stash apply'
alias gstd  'git stash drop'
alias gstl  'git stash list'
alias gstp  'git stash pop'
alias gsts  'git stash show --text'
alias gsu 'git submodule update'

alias gts 'git tag -s'
alias gtv 'git tag | sort -V'

# alias gunignore='git update-index --no-assume-unchanged'
# alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
# alias gup='git pull --rebase'
# alias gupv='git pull --rebase -v'
# alias glum='git pull upstream master'
#
# alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
# alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'
#
alias gfx 'git fixup'

alias lg 'git fzf show'

# # ref: bin/git-fzf
# alias -g GH '$(git fzf)'
