# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc
export GHQ_ROOT="$HOME/.ghq"
if (( ${+commands[ghq]} )); then
  if [[ ! -d "$GHQ_ROOT/github.com/masa0x80/dotfiles" ]]; then
    export DOTFILE="$GHQ_ROOT/github.com/masa0x80/dotfiles"
  else
    export DOTFILE="${DOTFILE:-$HOME/.dotfiles}"
  fi
fi
