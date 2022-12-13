git-add() {
  local files=($(git status --porcelain | fzf -m --query="$@" | cut -c4- | sed -e 's|^|:/|' | tr "\n" ' '))
  if test -n "$files"; then
    BUFFER="git add"
    for f in $files; do
      BUFFER+=" $f"
    done
    zle end-of-line
    zle accept-line
  fi
}
zle -N git-add
bindkey "^g^a" git-add
