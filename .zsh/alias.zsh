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

alias gsh='git show'
compdef _git gsh=git-show
alias gdc='git diff --cached'
compdef _git gdc=git-diff

alias diff='diff -u'

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

alias s='spring stop && spring rails s'
alias c='rails c'
alias db='rails db'

alias h='\history -n -r 1 | grep "$@"'

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g P='| peco'
