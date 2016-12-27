if (( $+commands[fzf] )); then
  if [[ ! "$MANPATH" == *$HOME/.zplug/repos/junegunn/fzf/man* && -d "$HOME/.zplug/repos/junegunn/fzf/man" ]]; then
    export MANPATH="$MANPATH:$HOME/.zplug/repos/junegunn/fzf/man"
  fi

  # ref: http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
  complete-ssh-host() {
    local host="$(command egrep -i '^Host\s+.+' $HOME/.ssh/config $(find $HOME/.ssh/conf.d -type f 2>/dev/null) | command egrep -v '[*?]' | awk '{print $2}' | sort | fzf)"

    if [ ! -z "$host" ]; then
      LBUFFER+="$host"
    fi
    zle reset-prompt
  }
  zle -N complete-ssh-host
  bindkey '^s^s' complete-ssh-host
fi
