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

# grep
export GREP_COlOR='1;31'
export GREP_COlORS="mt=${GREP_COLOR}"
alias grep='grep --color=auto'

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

  $XDG_CACHE_HOME/zsh-cache.zsh(N)
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

# EDITOR
if (( ${+commands[nvim]} )); then
  export EDITOR=nvim
  alias vi=nvim
  # manpager
  export MANPAGER='nvim +Man!'
elif (( ${+commands[vim]} )); then
  export EDITOR=vim
  alias vi=vim
fi

# ls
if (( ${+commands[eza]} )); then
  alias ls='eza --group-directories-first --icons'
fi

# Pager
(( ${+commands[bat]} )) && export PAGER=bat

export AGE_IDENTITY="$HOME/.config/age/key.txt"
export AGE_RECIPIENT=$(grep -oP '(?<=# public key: ).+(?=)' $AGE_IDENTITY)
export PASSAGE_IDENTITIES_FILE="$HOME/.ssh/key"
export PASSAGE_RECIPIENTS_FILE="$HOME/.ssh/key.pub"
export PASSAGE_AGE="$HOMEBREW_PREFIX/bin/rage"

# less
export LESS='-RFIX'

# Browser
identifier="$(defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure | awk -F'"' '/http;/{print window[(NR)-1]}{window[NR]=$2}')"
case "$identifier" in
"net.kassett.finicky")
  TARGET_BROWSER="Vivaldi"
  ;;
"com.vivaldi.vivaldi")
  TARGET_BROWSER="Vivaldi"
  ;;
"com.microsoft.edgemac")
  TARGET_BROWSER="Microsoft Edge"
  ;;
"com.google.chrome")
  TARGET_BROWSER="Google Chrome"
  ;;
*)
  TARGET_BROWSER="Safari"
  ;;
esac
export TARGET_BROWSER
