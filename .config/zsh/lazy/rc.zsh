# Autoload functions
fpath=($ZDOTDIR/functions(N-/) $fpath)
for config_file ($ZDOTDIR/functions/*(N)) autoload $(basename "$config_file")

# Perform cd to a directory if the typed command is invalid, but is a directory.
setopt AUTO_CD

# Make cd push the old directory to the directory stack.
setopt AUTO_PUSHD

setopt CD_SILENT

# Don't push multiple copies of the same directory to the stack.
setopt PUSHD_IGNORE_DUPS

# Don't print the directory stack after pushd or popd.
setopt PUSHD_SILENT

# Have pushd without arguments act like `pushd ${HOME}`.
setopt PUSHD_TO_HOME

# Treat `#`, `~`, and `^` as patterns for filename globbing.
setopt EXTENDED_GLOB

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Allow comments starting with `#` in the interactive shell.
setopt INTERACTIVE_COMMENTS

# Disallow `>` to overwrite existing files. Use `>|` or `>!` instead.
setopt NO_CLOBBER

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# List jobs in verbose format by default.
setopt LONG_LIST_JOBS

# Prevent background jobs being given a lower priority.
setopt NO_BG_NICE

# Prevent status report of jobs on shell exit.
setopt NO_CHECK_JOBS

# Prevent SIGHUP to jobs on shell exit.
setopt NO_HUP

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

# EDITOR
if installed nvim; then
  export EDITOR=nvim
  alias vi=nvim
elif installed vim; then
  export EDITOR=vim
  alias vi=vim
fi

# ls
if installed eza; then
  alias ls='eza --group-directories-first --icons'
fi

# Pager
if_installed bat export PAGER=bat

# NOTE: must place after adding `/usr/local/bin` to PATH
export SHELL=$(which zsh)

# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc
if installed ghq; then
  if [[ ! -d $(ghq root)/github.com/masa0x80/dotfiles ]]; then
    export DOTFILE=$(ghq root)/github.com/masa0x80/dotfiles
  else
    export DOTFILE="${DOTFILE:-$HOME/.dotfiles}"
  fi
fi

# golang
export GO111MODULE=on
export GOPATH=$HOME/go

# asdf
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export NODEJS_CHECK_SIGNATURES=no

for file (
  # asdf
  $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh(N)
  $HOME/.asdf/plugins/java/set-java-home.zsh(N)
  # Load files under conf.d
  $ZDOTDIR/conf.d/*.zsh(N)
  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
  # Load local config
  $HOME/.zshrc.local(N)
) source $file

# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc`
path=(
  $HOME/.bin.local(N-/)
  $HOME/.bin(N-/)
  $path
)

# NOTE: Create zsh compiled files
() {
  local src
  for src in $@; do
    [ ! -f ${src}.zwc -o $src -nt ${src}.zwc ] && zcompile $src
  done
} $HOME/.zshenv(N) $ZDOTDIR/.zshrc(N) $ZDOTDIR/conf.d/*.zsh(N) $ZDOTDIR/hooks/*.zsh(N) $ZDOTDIR/lazy/*.zsh(N)
