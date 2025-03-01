r() {
  local repo=$(ghq list -p | sed -n "s|$HOME/\(.*\)|\1|p" | fzf +m --query="$@" --preview 'bat --color=always ~/{}/README.md')

  if test -n "$repo"; then
    cd "$HOME/$repo"
  fi
}
