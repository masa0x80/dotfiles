# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc`
path=(
  /nix/var/nix/profiles/default/bin(N-/)
  /etc/profiles/per-user/$USER/bin(N-/)
  /run/current-system/sw/bin(N-/)
  $HOME/.nix-profile/bin(N-/)

  $HOME/.bin.local(N-/)
  $HOME/.bin(N-/)
  $HOME/.local/bin(N-/)
  $path
)

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
) zsh-defer source $file

for file (
  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
  $HOME/.zshrc.local(N)
) source $file
