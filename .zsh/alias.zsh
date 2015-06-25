# 色設定
if type dircolors > /dev/null 2>&1; then
  eval $(dircolors $HOME/.zsh/custom/dircolors.256dark)
elif type gdircolors > /dev/null 2>&1; then
  eval $(gdircolors $HOME/.zsh/custom/dircolors.256dark)
fi
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# ls
if type gls > /dev/null 2>&1; then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -l'

alias gsh='git fetch'
compdef _git gf=git-fetch
alias glp='git log --decorate --stat -p --max-count=30'
compdef _git glp=git-log
alias gsh='git show'
compdef _git gsh=git-show

function git-review() {
  local N=$(git log --pretty=format:"%H %h" | grep -n $1 | cut -d : -f 1)
  git log --decorate --stat --reverse -p -$N
}
alias greview='git-review'

# autojumpした時はtmuxのwindow名をディレクトリー名に変更する
function jump-and-tmux-rename-window() {
  \j "$@"
  tmux rename-window ${PWD:t}
}
alias j='jump-and-tmux-rename-window'
