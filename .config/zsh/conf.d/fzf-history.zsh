# history with fzf
# ref: http://blog.kenjiskywalker.org/blog/2014/06/12/peco
# ref: http://qiita.com/uchiko/items/f6b1528d7362c9310da0
function history-fzf() {
  BUFFER=$(\history -n 1 | \
    fzf +m --ansi --tac --query "$LBUFFER")
  CURSOR=$#BUFFER
  [ -z "$BUFFER" ] && return 0
  zle clear-screen
}
zle -N history-fzf
bindkey '^R' history-fzf
