_tt() {
  if [ -e package.json ]; then
    BUFFER="npm run test"
  elif (( ${commands[rspec]} )); then
    BUFFER="rspec"
  else
    return 0
  fi
  CURSOR=$#BUFFER
}
zle -N _tt
bindkey '^t^t' _tt

