# プロファイル用設定
# (.zshenvの一番始めに記載すること)
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

# NOTE: Do not load global rc files
setopt no_global_rcs
setopt magic_equal_subst

PS1="%F{blue}%~%f"$'\n'"%F{magenta}彡:匚＞%f "

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

# homebrew
eval "$(brew shellenv)"

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
  $path
)
fpath=(
  $fpath
  $ZDOTDIR/functions(N-/)
  $HOMEBREW_PREFIX/share/zsh/site-functions(N-/)
)

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

export PURE_PROMPT_SYMBOL="%F{magenta}ミ:匚＞%f"

identifier="$(defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure | awk -F'"' '/http;/{print window[(NR)-1]}{window[NR]=$2}')"
case "$identifier" in
"net.kassett.finicky")
  BROWSER="Vivaldi"
  ;;
"com.vivaldi.vivaldi")
  BROWSER="Vivaldi"
  ;;
"com.microsoft.edgemac")
  BROWSER="Microsoft Edge"
  ;;
"com.google.chrome")
  BROWSER="Google Chrome"
  ;;
*)
  BROWSER="Safari"
  ;;
esac
export BROWSER

for file (
  # Load .config.local
  $HOME/.config.local/zsh/zshenv(N)
  # Load .zshenv.local
  $HOME/.zshenv.local(N)
) source $file
