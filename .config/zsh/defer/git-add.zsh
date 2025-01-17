git-add() {
  IFS=$'\n'
  for f in $(git -c color.status=always status -s | fzf -m --query="$@" \
    --preview 'F=$(echo {2..} | sed "s|\"\(.*\)\"|\1|");
      [[ {1} = "??" ]] && bat --color=always "$F" || \
      [[ {} =~ "^D. " ]] && git diff --color=always --cached -- "$F" || \
      [[ {} =~ "^[MA]. " ]] && git diff --color=always --staged -- "$F" || \
      git diff --color=always -- "$F"' | cut -c4-); do
    if [ "$BUFFER" = "" ]; then
      BUFFER="git add"
    fi
    BUFFER+=" ./$f"
    zle end-of-line
    zle accept-line
  done
}
zle -N git-add
bindkey "^g^a" git-add
