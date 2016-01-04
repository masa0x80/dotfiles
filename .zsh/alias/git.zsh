alias gsh='git show'
compdef _git gsh=git-show
alias gdc='git diff --cached'
compdef _git gdc=git-diff

function git-review() {
  local N=$(git log --pretty=format:"%H %h" | grep -n $1 | cut -d : -f 1)
  git log --decorate --stat --reverse -p -$N
}
alias gre='git-review'

function git-pull-and-prune() {
  git pull origin $(current_branch)
  git fetch --prune --tags --all && git branch --merged | egrep -v '^\*|\smaster$|\sdevelop$' | xargs git branch -d
}
alias ggpull='git-pull-and-prune'

# fshow - git commit browser (enter for show, ctrl-d for diff)
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}
alias lg='fshow'
