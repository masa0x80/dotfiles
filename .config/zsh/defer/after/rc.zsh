# XXX
compdef _zbnc_zsh_better_npm_completion npm

# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc
export GHQ_ROOT="$HOME/.ghq"
export DOTFILE="$GHQ_ROOT/github.com/masa0x80/dotfiles"
if [[ ! -d "$DOTFILE" ]]; then
  export DOTFILE="$HOME/.dotfiles"
fi

zsh-defer source $HOME/.bin/_set_browser

for file (
  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
  $HOME/.zshrc.local(N)
) source $file

# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc`
path=(
  $HOME/.bin.local(N-/)
  $HOME/.bin(N-/)
  $path
)
