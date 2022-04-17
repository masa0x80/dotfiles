git-branch() {
  local option=${1:-'-l'}
  shift
  local branch=$(git branch --format='%(refname:short)' --sort=-committerdate $option | fzf +m +s --query="$@")
  if test -n "$branch"; then
    if test "$BUFFER" = ''; then
      BUFFER="git switch"
      test "$option" = '-r' && BUFFER+=" -t"
      BUFFER+=" $branch"
      zle end-of-line
      zle accept-line
    else
      BUFFER="${LBUFFER}${branch}${RBUFFER}"
      CURSOR+=${#branch}
      zle redisplay
    fi
  fi
}
git-switch-local-branch() {
  git-branch "$@"
}
zle -N git-switch-local-branch
bindkey "^g^b" git-switch-local-branch

git-switch-remote-branch() {
  git-branch '-r' "$@"
}
zle -N git-switch-remote-branch
bindkey "^g^g^b" git-switch-remote-branch
