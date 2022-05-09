setopt nopromptbang prompt{cr,percent,sp,subst}

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info' verbose yes
  zstyle ':zim:git-info:action' format '%F{red}%s '
  zstyle ':zim:git-info:branch' format '%F{yellow} %b'
  zstyle ':zim:git-info:position' format '%F{magenta}%p'
  zstyle ':zim:git-info:commit' format '%F{yellow}%c'
  zstyle ':zim:git-info:stashed' format ' %F{cyan}✭'
  zstyle ':zim:git-info:indexed' format ' %F{green}✚'
  zstyle ':zim:git-info:unindexed' format ' %F{blue}✱'
  zstyle ':zim:git-info:untracked' format ' %F{white}◼'
  zstyle ':zim:git-info:behind' format ' %F{magenta}⬇'
  zstyle ':zim:git-info:ahead' format ' %F{magenta}⬆'
  zstyle ':zim:git-info:keys' format \
    'status' '%s$(coalesce "%b" "%p" "%c")%S%i%I%u%B%A%f'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

export PS1='%F{gray}${(%):-%~} ${(e)git_info[status]}%(?,,%F{red} [%?])
❯%f '
