if (( $+commands[fzf] )); then
  if [[ ! "$PATH" == *$HOME/.zplug/repos/junegunn/fzf/bin* ]]; then
    export PATH="$PATH:$HOME/.zplug/repos/junegunn/fzf/bin"
  fi

  if [[ ! "$MANPATH" == *$HOME/.zplug/repos/junegunn/fzf/man* && -d "$HOME/.zplug/repos/junegunn/fzf/man" ]]; then
    export MANPATH="$MANPATH:$HOME/.zplug/repos/junegunn/fzf/man"
  fi

  [[ $- == *i* ]] && source "$HOME/.zplug/repos/junegunn/fzf/shell/completion.zsh" 2> /dev/null

  source "$HOME/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh"

  bindkey '^Q' fzf-file-widget
fi
