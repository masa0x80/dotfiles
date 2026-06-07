if (( ${+commands[ghq]} )); then
  if [[ -d "$GHQ_ROOT/github.com/masa0x80/dotfiles" ]]; then
    export DOTFILES_DIR="$GHQ_ROOT/github.com/masa0x80/dotfiles"
  else
    export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
  fi
fi

r() {
  local repo=$(ghq list -p | sed "s|$HOME/||" | fzf +m --query="$@" \
    --preview 'bat --color=always ~/{}/README.md 2>/dev/null || echo "No README.md"')

  [[ -n "$repo" ]] && cd "$HOME/$repo"
}
