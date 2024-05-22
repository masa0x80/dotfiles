# Autoload functions
for config_file ($ZDOTDIR/functions/*(N)) autoload $(basename "$config_file")

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

# MANPAGER
export MANPAGER='nvim +Man!'

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

# misc
eval "$(mise activate zsh)"
eval "$(fzf --zsh)"

for file (
  # Load files under hoooks and conf.d
  $ZDOTDIR/hooks/*.zsh(N)
  $ZDOTDIR/conf.d/*.zsh(N)

  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
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
} $HOME/.zshenv(N) $ZDOTDIR/.zshrc(N) $ZDOTDIR/zinitrc(N) $ZDOTDIR/conf.d/*.zsh(N) $ZDOTDIR/hooks/*.zsh(N) $ZDOTDIR/lazy/*.zsh(N) $HOME/.local/share/zinit/zinit.git/*.zsh(N)
