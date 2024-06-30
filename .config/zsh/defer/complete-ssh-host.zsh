# ref: http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
complete-ssh-host() {
  local host="$(command grep -E -i '^Host\s+.+' $HOME/.ssh/config $(find $HOME/.ssh/conf.d -type f 2>/dev/null) | command grep -E -v '[*?]' | awk '{print $2}' | sort | fzf)"

  if [ ! -z "$host" ]; then
    LBUFFER+="$host"
  fi
  zle reset-prompt
}
zle -N complete-ssh-host
bindkey '^gs' complete-ssh-host
