# Initializes mcfly
if installed mcfly; then
  eval "$(mcfly init zsh)"
fi

# olets/zsh-abbr
bindkey '^J' abbr-expand-and-accept

# Key bindings
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
# include words that is at least two characters long
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
bindkey '^]' insert-last-word

bindkey "^[[Z" reverse-menu-complete
bindkey "^O" reverse-menu-complete

bindkey "^[u" undo
bindkey "^[r" redo

bindkey "^g^h" backward-word
bindkey "^g^l" forward-word
