# プロファイル用設定
# (.zshenvの一番始めに記載すること)
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

# NOTE: Do not load global rc files
setopt no_global_rcs
setopt magic_equal_subst

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Remove path separator from WORDCHARS
WORDCHARS="${WORDCHARS//[\/=]}"

# golang
export GO111MODULE=on
export GOPATH=$HOME/go

# RIPGREP
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/ripgreprc

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

export GIT_HOOK_DIR="$XDG_CONFIG_HOME/git/hooks"

export HOMEBREW_NO_ANALYTICS=1

export JIRA_BASE_URL='https://jira.atlassian.com'

# https://github.com/nivekuil/rip
export GRAVEYARD="$XDG_DATA_HOME/trash"

for file (
  # Load .config.local
  $HOME/.config.local/zsh/zshenv(N)
  # Load .zshenv.local
  $HOME/.zshenv.local(N)

  $XDG_CACHE_HOME/zshenv-cache.zsh(N)
) source $file

typeset -U path PATH
path=(
  $HOMEBREW_PREFIX/opt/curl/bin(N-/)
  $HOMEBREW_PREFIX/opt/openssl/bin(N-/)
  $HOMEBREW_PREFIX/opt/sqlite/bin(N-/)
  $HOMEBREW_PREFIX/opt/gettext/bin(N-/)
  $HOMEBREW_PREFIX/opt/gnu-getopt/bin(N-/)
  $HOMEBREW_PREFIX/opt/grep/libexec/gnubin(N-/)
  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin(N-/)
  $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin(N-/)

  # golang
  $GOPATH/bin(N-/)

  /opt/homebrew/bin(N-/)
  /usr/local/bin(N-/)

  $path
)
fpath=(
  $ZDOTDIR/functions(N-/)
  $fpath
)

# Pager
(( ${+commands[bat]} )) && export PAGER=bat

# less
export LESS='-RFIX'
