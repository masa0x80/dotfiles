if (( $+commands[open] )); then
  alias o='open'
fi

if (( $+commands[tldr] )); then
  alias man='tldr'
fi

if (( $+commands[mycli] )); then
  alias mysql='mycli'
fi

alias tailf='tail -f'
alias diff='diff -u'
alias watch='watch -n 0.5'
alias grep='command grep --color=auto'
alias egrep='command egrep --color=auto'
alias mkdir='mkdir -p'
alias md=mkdir
alias rd=rmdir
alias rf='rm -rf'

# ls
if (( $+commands[gls] )); then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi
if (( $+commands[exa] )); then
  alias l='exa -la --git'
  alias la='exa -la --git'
  alias ll='exa -l --git'
  alias ls='exa'
  alias tree='exa -T'
else
  alias l='ls -lAh'
  alias la='ls -lAh'
  alias ll='ls -lh'
fi

if (( $+commands[nvim] )); then
  alias vim='nvim'
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -g F='| fzf'
alias -g G='| pt'
alias -g H='| head'
alias -g L='| less'
alias -g N=' >/dev/null 2>&1'
alias -g N1=' >/dev/null'
alias -g N2=' 2>/dev/null'
alias -g P='| peco'
alias -g T='| tail'

if (( $+commands[htop] )); then
  alias top=htop
fi

alias h='\history -n -r 1 | grep "$@"'

alias sshconfig='vim ~/.ssh/config'
alias sconfig='sshconfig'
alias sconf='sshconfig'

web_server() {
  ruby -run -e httpd . -p ${1:-3000}
}

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
