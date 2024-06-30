# # NOTE: Create zsh compiled files
# () {
#   local src
#   for src in $@; do
#     [ ! -f ${src}.zwc -o $src -nt ${src}.zwc ] && zcompile $src
#   done
# } $HOME/.zshenv(N) $ZDOTDIR/.zshrc(N) $ZDOTDIR/*.zsh(N) $ZDOTDIR/defer/*.zsh(N)
