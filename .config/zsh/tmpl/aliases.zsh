# grep
export GREP_COlOR='1;31'
export GREP_COlORS="mt=${GREP_COLOR}"
alias grep='grep --color=auto'

# EDITOR
if (( ${+commands[nvim]} )); then
  export EDITOR=nvim
  alias vi=nvim
  # manpager
  export MANPAGER='nvim +Man!'
elif (( ${+commands[vim]} )); then
  export EDITOR=vim
  alias vi=vim
fi

# ls
if (( ${+commands[eza]} )); then
  alias ls='eza --icons --group-directories-first'
fi
