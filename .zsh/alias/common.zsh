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

alias h='\history -n -r 1 | grep "$@"'

# refs: http://qiita.com/yuku_t/items/4ffaa516914e7426419a
function ssh() {
  local window_name=$(tmux display -p '#{window_name}')
  command ssh $@
  tmux rename-window $window_name
}
