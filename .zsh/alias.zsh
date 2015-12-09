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
alias diff='diff -u'
alias grep='egrep --color'

alias gsh='git show'
compdef _git gsh=git-show
alias gdc='git diff --cached'
compdef _git gdc=git-diff

function git-review() {
  local N=$(git log --pretty=format:"%H %h" | grep -n $1 | cut -d : -f 1)
  git log --decorate --stat --reverse -p -$N
}
alias gre='git-review'

function git-pull-and-prune() {
  git pull origin $(current_branch)
  git fetch --prune --tags --all && git branch --merged | egrep -v '^\*|\smaster$|\sdevelop$' | xargs git branch -d
}
alias ggpull='git-pull-and-prune'

# autojumpした時はtmuxのwindow名をディレクトリー名に変更する
function jump-and-tmux-rename-window() {
  \j "$@"
  tmux rename-window ${PWD:t}
}
alias j='jump-and-tmux-rename-window'

function direnv-init() {
  echo 'export PATH=$PWD/bin:$PWD/vendor/bin:$PATH' > .envrc && direnv allow
}
alias env_init='direnv-init'

alias s='spring rails s -p $RAILS_SERVER_PORT'
alias ss="pkill -f 'ruby .*/bin/spring'; pkill -f 'spring app'; pkill -f 'spring server'"
alias c='rails c'
alias t='rspec'
alias bi='bundle install --path=vendor/bundle'
alias bil='bundle install --path=vendor/bundle --local'
alias db='rails db'

alias h='\history -n -r 1 | grep "$@"'

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| egrep --color'
alias -g P='| peco'
