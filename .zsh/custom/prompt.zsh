_prompt() {
  counter=$(expr $(expr ${counter:-2} + 1) % 2)
  PROMPT_SUFFIX='匚＞'
  if [ $counter -eq 0 ]; then
    PROMPT_PREFIX='ミ'
  else
    PROMPT_PREFIX='彡'
  fi
  PROMPT="%(?.%F{magenta}${PROMPT_PREFIX}:.%F{red}${PROMPT_PREFIX}X)${PROMPT_SUFFIX}%f "
}
add-zsh-hook precmd _prompt
