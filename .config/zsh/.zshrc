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

setopt auto_cd
setopt auto_pushd
setopt auto_param_slash
setopt auto_menu
setopt cd_silent
setopt pushd_ignore_dups
setopt list_packed
setopt list_types
setopt auto_list
setopt magic_equal_subst
setopt brace_ccl
setopt nolistbeep
setopt extended_glob
setopt interactive_comments
setopt long_list_jobs
setopt no_bg_nice
setopt no_check_jobs
setopt no_hup

setopt correct

bindkey -e

if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
HISTSIZE=30000
SAVEHIST=30000

setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_verify
setopt share_history

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

(( ${+commands[sheldon]} )) && eval "$(sheldon source)"
(( ${+commands[starship]} )) && eval "$(starship init zsh)"
(( ${+commands[mise]} )) && eval "$(mise activate zsh)"
(( ${+commands[fzf]} )) && eval "$(fzf --zsh)"
(( ${+commands[direnv]} )) && eval "$(direnv hook zsh)"
(( ${+commands[zabrze]} )) && eval "$(zabrze init --bind-keys)"

zsh_dir="$ZDOTDIR/zsh.d"
for file (
  $zsh_dir/checker.zsh(N)
  $zsh_dir/tmux-pool-sync.zsh(N)
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

  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
  $HOME/.zshrc.local(N)
) source $file
