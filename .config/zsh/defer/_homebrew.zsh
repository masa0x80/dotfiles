# homebrew
cache_file="$ZDOTDIR/cache/brew.zsh"
test -r "$cache_file" || brew shellenv > $cache_file
# Do not apply `zsh-defer`
source $cache_file

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

# misc
cache_file="$ZDOTDIR/cache/mise.zsh"
test -r "$cache_file" || mise activate zsh > $cache_file
cache_file="$ZDOTDIR/cache/fzf.zsh"
test -r "$cache_file" || fzf --zsh > $cache_file
cache_file="$ZDOTDIR/cache/direnv.zsh"
test -r "$cache_file" || direnv hook zsh > $cache_file
for file (
  $ZDOTDIR/cache/mise.zsh(N)
  $ZDOTDIR/cache/fzf.zsh(N)
  $ZDOTDIR/cache/direnv.zsh(N)
) zsh-defer source $file

zsh-defer find $ZDOTDIR/cache -type f -mtime +7 | xargs -I{} rm {}

export AGE_IDENTITY="$HOME/.config/age/key.txt"
export AGE_RECIPIENT=$(grep -oP '(?<=# public key: ).+(?=)' $AGE_IDENTITY)
export PASSAGE_IDENTITIES_FILE="$HOME/.ssh/key"
export PASSAGE_RECIPIENTS_FILE="$HOME/.ssh/key.pub"
export PASSAGE_AGE="$HOMEBREW_PREFIX/bin/rage"
