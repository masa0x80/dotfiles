ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[white]%}"
_PS1=$'
%F{blue}%~%f $(gitprompt)%f
'

_prompt() {
  counter=$(expr $(expr ${counter:-2} + 1) % 2)
  local prompt_suffix='匚＞'
  if [ $counter -eq 0 ]; then
    prompt_prefix='ミ'
  else
    prompt_prefix='彡'
  fi
  PS1="${_PS1}%(!.#.%(?,%F{magenta}${prompt_prefix}:,%F{red}${prompt_prefix}X)${prompt_suffix})%f "
}
add-zsh-hook precmd _prompt
