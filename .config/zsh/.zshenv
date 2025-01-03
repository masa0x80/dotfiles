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

typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /usr/local/bin(N-/)
  $path
)

# golang
export GO111MODULE=on
export GOPATH=$HOME/go

# RIPGREP
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/ripgreprc

# grep
export GREP_COlOR='1;31'
export GREP_COlORS="mt=${GREP_COLOR}"
alias grep='grep --color=auto'

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

export GIT_HOOK_DIR="$HOME/.config/git/hooks"

export HOMEBREW_NO_ANALYTICS=1

export JIRA_BASE_URL='https://jira.atlassian.com'

# https://github.com/nivekuil/rip
export GRAVEYARD="$XDG_DATA_HOME/trash"

for file (
  # Load .config.local
  $HOME/.config.local/zsh/zshenv(N)
  # Load .zshenv.local
  $HOME/.zshenv.local(N)
) source $file
