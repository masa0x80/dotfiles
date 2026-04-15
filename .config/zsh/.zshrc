source "$XDG_CACHE_HOME/zshrc-cache.zsh"

zsh_dir="$ZDOTDIR/zsh.d"
for file (
  $zsh_dir/init.zsh(N)
) source $file

for file (
  $zsh_dir/checker.zsh(N)
  $zsh_dir/aliases.zsh(N)
  $zsh_dir/complete-ssh-host.zsh(N)
  $zsh_dir/completion.zsh(N)
  $zsh_dir/dotdot.zsh(N)
  $zsh_dir/fzf.zsh(N)
  $zsh_dir/ghq.zsh(N)
  $zsh_dir/git.zsh(N)
  $zsh_dir/key-bindings.zsh(N)
  $zsh_dir/navi.zsh(N)
  $zsh_dir/prompt.zsh(N)

  # Load gcloud
  $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc(N)
  $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc(N)
) zsh-defer source $file

# zabrze
source "$XDG_CACHE_HOME/zabrze-cache.zsh"

for file (
  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
  $HOME/.zshrc.local(N)
) source $file

# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc`
path=(
  $HOME/.bin.local(N-/)
  $HOME/.bin(N-/)
  $HOME/.local/bin(N-/)
  $path
)
