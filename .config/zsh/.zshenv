# Configurations for zsh {{{

# NOTE: Do not load global rc files
setopt no_global_rcs
setopt magic_equal_subst

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Autoload functions
fpath=($ZDOTDIR/functions(N-/) $fpath)
autoload -U compinit && compinit
for config_file ($ZDOTDIR/functions/*(N)) autoload $(basename "$config_file")

typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /usr/local/bin(N-/)
  $path
)
# homebrew
eval "$(brew shellenv)"

# NOTE: must place after adding `/usr/local/bin` to PATH
export SHELL=$(which zsh)
export TERM=screen-256color

# golang
export GO111MODULE=on
export GOPATH=$HOME/go

path=(
  # brew caveats
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
  # rust
  $HOME/.cargo/bin(N-/)
  $path
)

# brew caveats
LDFLAGS="-I$HOMEBREW_PREFIX/opt/openssl/lib"
CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl/include"
PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/openssl/lib/pkgconfig"

# asdf
export NODEJS_CHECK_SIGNATURES=no
load_file "$HOMEBREW_PREFIX/opt/asdf/asdf.sh"
load_file $HOME/.asdf/plugins/java/set-java-home.zsh

# EDITOR
if installed nvim; then
  export EDITOR=nvim
elif installed vim; then
  export EDITOR=vim
fi

# fzf options
# https://github.com/zimfw/fzf で `--ansi` は追加されるので、それ以外を設定
export FZF_DEFAULT_OPTS='--reverse --extended --multi --cycle --bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-g:toggle-all,ctrl-/:deselect-all,ctrl-q:deselect-all'

# RIPGREP
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/ripgreprc

# grep
export GREP_COlOR='1;31'
export GREP_COlORS="mt=${GREP_COLOR}"
alias grep='grep --color=auto'

# Pager
if_installed bat export PAGER=bat

# less
export LESS='-RFIX'
# colored less (0: Black, 1: Red, 2: Green, 3: Yellow, 4: Blue, 5: Magenta, 6: Cyan, 7: White)
export LESS_TERMCAP_mb=$(tput bold)                             # begin blinking
export LESS_TERMCAP_md=$(tput bold; tput setaf 2)               # begin bold
export LESS_TERMCAP_me=$(tput sgr0)                             # end mode
export LESS_TERMCAP_se=$(tput sgr0)                             # end standout-mode
export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 7) # begin standout-mode
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)                  # end underline
export LESS_TERMCAP_us=$(tput smul; tput setaf 4)               # begin underline

# rails (for rails server alias)
export RAILS_SERVER_PORT=3000

export GIT_HOOK_DIR="$HOME/.config/git/hooks"

# NOTE: must place before loading `$HOME/.config.local/zsh/zshenv`
if installed ghq; then
  if [[ ! -d $(ghq root)/github.com/masa0x80/dotfiles ]]; then
    export DOTFILE=$(ghq root)/github.com/masa0x80/dotfiles
  else
    export DOTFILE="${DOTFILE:-$HOME/.dotfiles}"
  fi
fi

# Load local configurations (zshenv)
load_file $HOME/.config.local/zsh/zshenv

# Load proxy config
load_file $HOME/.zshenv.local

# NOTE: Create zsh compiled files
() {
  local src
  for src in $@; do
    [ ! -f ${src}.zwc -o $src -nt ${src}.zwc ] && zcompile $src
  done
} $HOME/.zshenv $ZDOTDIR/.zshrc $HOME/.local/share/zinit/zinit.git/*.zsh(N)


# }}}
