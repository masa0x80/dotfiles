if (( $+commands[fzf] )); then
  if [[ ! "$MANPATH" == *$HOME/.zplug/repos/junegunn/fzf/man* && -d "$HOME/.zplug/repos/junegunn/fzf/man" ]]; then
    export MANPATH="$MANPATH:$HOME/.zplug/repos/junegunn/fzf/man"
  fi
fi
