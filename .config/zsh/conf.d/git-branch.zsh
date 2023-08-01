git-switch-local-branch() {
  local branch=$(git branch --format='%(refname:short)' --sort=-committerdate -l | fzf +m +s --preview 'git log --graph {1} --format="%C(auto)%h%d %s %C(blue)%cr %C(green)%cN"')
  if test -n "$branch"; then
    if test "$BUFFER" = ''; then
      BUFFER="git switch $branch"
      zle end-of-line
      zle accept-line
    else
      BUFFER="${LBUFFER}${branch}${RBUFFER}"
      CURSOR+=${#branch}
      zle redisplay
    fi
  fi
}
zle -N git-switch-local-branch
bindkey "^g^b" git-switch-local-branch

git-switch-remote-branch() {
  git fetch
  local branch=$(git branch --format='%(refname:short)' --sort=-committerdate -r | grep -Ev '^origin$' | fzf +m +s --query="$BUFFER" --preview 'git log --graph {1} --format="%C(auto)%h%d %s %C(blue)%cr %C(green)%cN"' | sed -e 's|origin/||')
  if test -n "$branch"; then
    git branch --format='%(refname:short)' --sort=-committerdate -l | grep -E -q "^${branch}$"
    if [ "$?" = 1 ]; then
      BUFFER="git switch -t origin/$branch"
    else
      BUFFER="git switch $branch"
    fi
    zle end-of-line
    zle accept-line
  fi
}
zle -N git-switch-remote-branch
bindkey "^g^g^b" git-switch-remote-branch
