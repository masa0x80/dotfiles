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

# reegnz/jq-zsh-plugin
bindkey '^G^J' jq-complete

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# ref. [最近のzshrcとその解説](https://mollifier.hatenablog.com/entry/20090502/p1)
# quote previous word in single or double quote
autoload -U modify-current-argument
_quote-previous-word-in-single() {
  modify-current-argument '${(qq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

_quote-previous-word-in-double() {
  modify-current-argument '${(qqq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double
