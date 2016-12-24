if (( $+commands[fzf] )); then
  if [[ ! "$MANPATH" == *$HOME/.zplug/repos/junegunn/fzf/man* && -d "$HOME/.zplug/repos/junegunn/fzf/man" ]]; then
    export MANPATH="$MANPATH:$HOME/.zplug/repos/junegunn/fzf/man"
  fi

  # ref: http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
  complete-ssh-host() {
    local res="$(
      ruby -e "Dir.glob('$HOME/.ssh/{config,conf.d/**/*}').map do |file|
        File.read(file).scan(/Host ([^*?\s]+)\n(?:[^#H\s][^\n]*\n)*/i).each do |m|
          puts m[0]
        end
      end" | sort | fzf
    )"

    local host=$(echo "$res" | cut -d ' ' -f1)

    if [ ! -z "$res" ]; then
      LBUFFER+="$host"
    fi
    zle reset-prompt
  }
  zle -N complete-ssh-host
  bindkey '^s^s' complete-ssh-host
fi
