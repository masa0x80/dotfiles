alias diff='diff -u'
alias grep='egrep --color'
alias rf='rm -rf'

# ls
if type gls > /dev/null 2>&1; then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -l'

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| egrep --color'
alias -g P='| peco'
alias -g F='| fzf'

# autojumpした時はtmuxのwindow名をディレクトリー名に変更する
function jump-and-tmux-rename-window() {
  \j "$@"
  tmux rename-window ${PWD:t}
}
alias j='jump-and-tmux-rename-window'

alias h='\history -n -r 1 | grep "$@"'
