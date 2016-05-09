alias diff='diff -u'
alias watch='watch -n 0.5'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias md='mkdir -p'
alias rd=rmdir
alias rf='rm -rf'

# ls
if (( $+commands[gls] )); then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

if (( $+commands[nvim] )); then
  alias vim='nvim'
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -g F='| fzf'
alias -g G='| egrep --color=auto'
alias -g H='| head'
alias -g L='| less'
alias -g N=" >/dev/null 2>&1"
alias -g N1=" >/dev/null"
alias -g N2=" 2>/dev/null"
alias -g P='| peco'
alias -g T='| tail'

if (( $+commands[htop] )); then
  alias top=htop
fi

alias h='\history -n -r 1 | grep "$@"'

# refs: http://qiita.com/yuku_t/items/4ffaa516914e7426419a
ssh() {
  local window_name=$(tmux display -p '#{window_name}')
  command ssh $@
  tmux rename-window $window_name
}

sudo() {
  if [[ $1 == -- ]]; then
    shift
    command sudo "$@"
  elif [[ $1 =~ ^vim?$ ]] && (( $+commands[sudo] )); then
    shift
    command sudo -e "$@"
  else
    command sudo "$@"
  fi
}
