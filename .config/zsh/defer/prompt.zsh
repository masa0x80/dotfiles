_prompt() {
  counter=$(expr $(expr ${counter:-1} + 1) % 2)
  local prompt_suffix='匚＞'
  if [ $counter -eq 0 ]; then
    prompt_prefix='ミ'
  else
    prompt_prefix='彡'
  fi
  PURE_PROMPT_SYMBOL="%(!.#.%(?,%F{magenta}${prompt_prefix}:,%F{red}${prompt_prefix}X)${prompt_suffix})%f"
}
add-zsh-hook precmd _prompt
