# git-add with peco
# ref: http://petitviolet.hatenablog.com/entry/20140722/1406034439
function peco-git-add() {
  local SELECTED_FILE_TO_ADD="$(git status --porcelain  | \
                                peco --query "$LBUFFER" | \
                                awk -F ' ' '{print $NF}')"
  if [ -n "$SELECTED_FILE_TO_ADD" ]; then
    BUFFER="git add $(echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' ')"
    CURSOR=$#BUFFER
    zle accept-line
  fi
}
zle -N peco-git-add
bindkey "^ga"  peco-git-add
bindkey "^g^a" peco-git-add

# git-checkout with peco
# ref: http://shibayu36.hatenablog.com/entry/2014/07/26/151106
function peco-git-recent-branches() {
  local SELECTED_BRANCH="$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
                           sed -e 's|^refs/heads/||'                                               | \
                           peco)"
  if [ -n "$SELECTED_BRANCH" ]; then
    if [ -n "$BUFFER" ]; then
      BUFFER="${BUFFER}${SELECTED_BRANCH}"
    else
      BUFFER="git checkout ${SELECTED_BRANCH}"
      zle accept-line
    fi
  fi
  zle clear-screen
}
zle -N peco-git-recent-branches
bindkey "^gb"  peco-git-recent-branches
bindkey "^g^b" peco-git-recent-branches

function peco-git-recent-all-branches() {
  local SELECTED_BRANCH="$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
                           sed -e 's|^refs/\(heads\|remotes\)/||'                                  | \
                           peco)"
  if [ -n "$SELECTED_BRANCH" ]; then
    if [ -n "$BUFFER" ]; then
      BUFFER="${BUFFER}${SELECTED_BRANCH}"
    else
      BUFFER="git checkout -t ${SELECTED_BRANCH}"
      zle accept-line
    fi
  fi
  zle clear-screen
}
zle -N peco-git-recent-all-branches
bindkey "^g^g^b"  peco-git-recent-all-branches

# history with peco
# ref: http://blog.kenjiskywalker.org/blog/2014/06/12/peco
# ref: http://qiita.com/uchiko/items/f6b1528d7362c9310da0
function peco-select-history() {
  local TAC
  if which tac > /dev/null; then
    TAC='tac'
  else
    TAC='tail -r'
  fi
  BUFFER=$(\history -n 1 | \
    eval $TAC | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# ssh with peco
# ref: http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
function peco-ssh() {
  # Hostの次の行にあるコメントをホスト名と一緒に表示するためのrubyワンライナー
  #
  # Host {KEYWORD}
  #   # {COMMENT}
  #   HostName {HOST_NAME}
  #
  # 上記フォーマットをパースして "KEYWORD  # COMMENT" に変換します
  BUFFER="ssh $(
    ruby -e "File.read('$HOME/.ssh/config').scan(/#[ \t]+Host|Host ([^*?\s]+)\n\s+(# [^\n]+)\n|Host ([^*?\s]+)\n/).each do |info|
      unless info.first.nil?
        puts "#{info[0]}\t#{info[1]}"
      else
        puts info.last
      end
    end" | sort | peco | cut -f 1
  )"
  CURSOR=4
  if [[ $#BUFFER = 4 ]]; then
    BUFFER=''
  fi
  zle clear-screen
}
zle -N peco-ssh
bindkey '^s^s' peco-ssh

# pt and vim with peco
# ref: http://qiita.com/fmy/items/b92254d14049996f6ec3
function peco-pt-vim () {
  local SELECTED_FILES
  if [[ $# = 0 ]]; then
    SELECTED_FILES=$(pt '' | peco)
  else
    local ARG=$1
    [[ $# > 0 ]] && shift
    SELECTED_FILES=$(pt "$ARG" | peco --query "$*")
  fi
  if [ -z $SELECTED_FILES ]; then
    return
  fi
  local N="$(echo $SELECTED_FILES | awk '{print $1}' | sort -u | wc -l)" # ファイル数を調べる
  local FILES
  if [ $N -eq 1 ]; then
    # 1ファイルなら行指定で開く
    echo $SELECTED_FILES | awk -F : '{print "-c " $2 " " $1}'
    FILES=$(echo $SELECTED_FILES | awk -F : '{print "-c " $2 " " $1}')
  elif [ $N -gt 1 ]; then
    # 複数ファイルを開く
    FILES=$(echo $SELECTED_FILES | awk -F : '{print $1}' | sort)
  fi
  if [ -n "$FILES" ]; then
    vim $(echo $FILES)
  fi
}
alias pv='peco-pt-vim'

# vim open with peco
function peco-find-vim () {
  local FILES
  if [ $(git rev-parse --is-inside-work-tree 2> /dev/null) = 'true' ]; then
    FILES=$(echo $(git ls-files -o --exclude-standard) $(git ls-files) | tr ' ' '\n' | peco --query "$*" | tr '\n' ' ')
  else
    FILES=$(find . | peco --query "$*" | tr '\n' ' ')
  fi
  if [ -n "$FILES" ]; then
    vim $(echo $FILES)
  fi
}
alias v='peco-find-vim'

# kill with peco
function pkill() {
  if [[ $1 =~ "^-" ]]; then
    local OPTION=$1
    [[ $# > 0 ]] && shift
    ps -ef | grep -v 'peco --query' | peco --query "$*" | awk '{print $2}' | xargs kill $OPTION
  else
    ps -ef | grep -v 'peco --query' | peco --query "$*" | awk '{print $2}' | xargs kill
  fi
}

# ps with peco
function psp() {
  if [[ $# = 0 ]]; then
    ps -ef | peco
  else
    ps -ef | peco --query "$*"
  fi
}
