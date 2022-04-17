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

export _PS1='%F{gray}$(abbr-current-dir) ${(e)git_info[status]}%(?,,%F{red} [%?])
'

_prompt() {
  counter=$(expr $(expr ${counter:-2} + 1) % 2)
  local prompt_suffix='匚＞'
  if [ $counter -eq 0 ]; then
    prompt_prefix='ミ'
  else
    prompt_prefix='彡'
  fi
  PS1="${_PS1}%(?,%F{gray}${prompt_prefix}:,%F{red}${prompt_prefix}X)${prompt_suffix}%f "
}
add-zsh-hook precmd _prompt

# ^M で2行プロンプトを1行に戻す
_accept-line() {
  local saved_prompt=$PS1
  PS1='%F{gray}$ %f'
  zle reset-prompt
  zle _abbr_widget_expand_and_accept
  PS1=$saved_prompt
}
zle -N _accept-line
bindkey '^M' _accept-line
