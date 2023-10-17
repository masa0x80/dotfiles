# Key bindings
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
# include words that is at least two characters long
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
bindkey "^]" insert-last-word

# Shift-Tabで補完候補を逆順で選択する
bindkey '^[[Z' reverse-menu-complete
# Ctrl-oで補完候補を逆順で選択する
bindkey '^O' reverse-menu-complete

bindkey '^G^U' undo
bindkey '^G^R' redo

bindkey '^G^H' backward-word
bindkey '^G^L' forward-word

# zabrze (brewで入れる想定)
eval "$(zabrze init --bind-keys)"
