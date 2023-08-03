git-add() {
  local files=($(git -c color.status=always status -s | fzf -m --query="$@" --preview '[[ {1} = "??" ]] && bat --color=always {-1} || [[ {} =~ "^ M" ]] && git diff --color=always {-1} || [[ {} =~ "^D " || {} =~ "^.D" ]] && : || git diff --staged --color=always {-1}' | cut -c4- | sed -e 's|^|:/|' | tr "\n" ' '))

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
