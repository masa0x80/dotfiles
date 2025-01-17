__call_navi() {
  navi --path .cheats.d/:"$(navi info cheats-path)" --fzf-overrides --no-exact --print --query="$@"
}

navi-widget() {
  local result="$(__call_navi "$BUFFER" | perl -pe 'chomp if eof')"
  BUFFER="$result"
  zle end-of-line
  zle redisplay
}
zle -N navi-widget
bindkey "^g^i" navi-widget
