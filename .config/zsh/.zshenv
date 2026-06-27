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

# ghq
export GHQ_ROOT="$HOME/.ghq"

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

export TARGET_BROWSER='Safari'
export JIRA_BASE_URL='https://jira.atlassian.com'

# https://github.com/nivekuil/rip
export GRAVEYARD="$XDG_DATA_HOME/trash"

export AGE_IDENTITY="$HOME/.ssh/age"
export AGE_RECIPIENT="$HOME/.ssh/age.pub"
export PASSAGE_IDENTITIES_FILE="$HOME/.ssh/key"
export PASSAGE_RECIPIENTS_FILE="$HOME/.ssh/key.pub"
export PASSAGE_AGE="$HOMEBREW_PREFIX/bin/rage"

for file (
  # Load .config.local
  $HOME/.config.local/zsh/zshenv(N)
  # Load .zshenv.local
  $HOME/.zshenv.local(N)
) source $file

typeset -U path PATH
path=(
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
eval "$(brew shellenv)"

# Pager
(( ${+commands[bat]} )) && export PAGER=bat

# less
export LESS='-RFIX'
