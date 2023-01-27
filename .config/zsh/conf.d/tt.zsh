_tt() {
  local opt=""
  if (( ${+commands[rspec]} )); then
    opt="${opt}rspec\n"
  fi
  if [ -e package.json ]; then
    opt="${opt}npm run test\n"
  fi
  BUFFER=$(echo -n $opt | fzf -1 +m)
  test -n "$BUFFER" || return 0
  CURSOR=$#BUFFER
}
zle -N _tt
bindkey '^t^t' _tt
