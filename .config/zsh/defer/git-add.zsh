git-add() {
  local files=(
    $(git -c color.status=always status -s | fzf -m --query="$@" \
      --preview 'F=$(echo {2..} | sed "s|\"\(.*\)\"|\1|"); [[ {1} = "??" ]] && bat --color=always "$F" || [[ {1} = "MM" ]] && git diff --color=always "$F" || [[ {} =~ "^ M" ]] && git diff --color=always "$F" || [[ {} =~ "^D " || {} =~ "^.D" ]] && : || git diff --staged --color=always "$F"' | cut -c4- | sed -e 's|^|:|' | tr "\n" ' ')
  )

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
