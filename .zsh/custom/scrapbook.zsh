export SCRAPBOOK_DIR=${SCRAPBOOK_DIR:-$HOME/.scrapbook}

if (( $+commands[fzf] && $+commands[mdv] )) && [ -e $SCRAPBOOK_DIR ]; then
  scrapbook() {
    local filename=$(find $SCRAPBOOK_DIR -type f | fzf --query "$*")
    LBUFFER="mdv"
    BUFFER+=" $filename"
    zle clear-screen
  }
  zle -N scrapbook
  bindkey '^s^b' scrapbook
fi
