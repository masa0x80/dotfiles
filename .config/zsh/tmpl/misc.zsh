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
# colored less (0: Black, 1: Red, 2: Green, 3: Yellow, 4: Blue, 5: Magenta, 6: Cyan, 7: White)
export LESS_TERMCAP_mb=$(tput bold) # begin blinking
export LESS_TERMCAP_md=$(
  tput bold
  tput setaf 2
)                                   # begin bold
export LESS_TERMCAP_me=$(tput sgr0) # end mode
export LESS_TERMCAP_se=$(tput sgr0) # end standout-mode
export LESS_TERMCAP_so=$(
  tput bold
  tput setaf 0
  tput setab 7
) # begin standout-mode
export LESS_TERMCAP_ue=$(
  tput rmul
  tput sgr0
) # end underline
export LESS_TERMCAP_us=$(
  tput smul
  tput setaf 4
) # begin underline
