if (( ${+commands[ghq]} )); then
  if [[ -d "$GHQ_ROOT/github.com/masa0x80/dotfiles" ]]; then
    export DOTFILES_DIR="$GHQ_ROOT/github.com/masa0x80/dotfiles"
  else
    export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
  fi
fi

r() {
  local root=$(ghq root)
  cd "$root/$(ghq list | fzf +m --query="$@" --preview "bat --color=always $root/{}/README.md 2>/dev/null || echo 'No README.md'")"
}
