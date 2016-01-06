if type peco > /dev/null 2>&1; then
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
          puts sprintf('%s %s', info[0].ljust(30, ' '), info[1])
        else
          puts info.last
        end
      end" | sort | peco | cut -d ' ' -f 1
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
      # 複数ファイルを開く (ファイル名に空白が含まれている場合はうまく動かない)
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

  # ps with peco
  function psp() {
    if [[ $# = 0 ]]; then
      ps -ef | peco
    else
      ps -ef | peco --query "$*"
    fi
  }
fi
