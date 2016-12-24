if [ -r $HOME/.zplug/zplug ]; then
  if (( $+commands[peco] )); then
    zstyle ":anyframe:selector:" use peco
  fi

  # history
  bindkey '^r'   anyframe-widget-put-history

  # git branch
  bindkey '^gb'   anyframe-widget-checkout-git-branch
  bindkey '^g^b'  anyframe-widget-checkout-git-branch
  bindkey '^g^gb' anyframe-widget-insert-git-branch
  bindkey '^gB'   anyframe-widget-insert-git-branch
fi

if (( $+commands[peco] )); then
  alias -g PECO='$((git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print) 2> /dev/null | peco --query "$*")'

  # git-add with peco
  # ref: http://petitviolet.hatenablog.com/entry/20140722/1406034439
  peco-git-add() {
    local git_root="$(git rev-parse --show-cdup)"
    local selected_file_to_add="$(git status --porcelain   | \
                                  peco --query "$LBUFFER"  | \
                                  awk -F ' ' '{print $NF}' | \
                                  xargs -I % echo "$git_root%")"
    if [ -n "$selected_file_to_add" ]; then
      BUFFER="git add $(echo "$selected_file_to_add" | tr '\n' ' ')"
      CURSOR=$#BUFFER
      zle accept-line
    fi
  }
  zle -N peco-git-add
  bindkey "^ga"  peco-git-add
  bindkey "^g^a" peco-git-add

  peco-git-recent-all-branches() {
    local SELECTED_BRANCH="$(git for-each-ref --format='%(refname)' --sort=-committerdate | \
                             sed -e 's|^refs/\(heads\|remotes\)/||'                       | \
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

  alias -g GST='$(git status -s -uno | peco --query "$*" | awk "{print \$2}")'

  peco-ghq-cd() {
    local repository_path=$(ghq list --full-path | sed -e "s|$HOME/||g" | peco --query "$LBUFFER")
    if [ -n "$repository_path" ]; then
      BUFFER="cd ~/$repository_path"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-ghq-cd
  bindkey '^gc' peco-ghq-cd

  # pt and vim with peco
  # ref: http://qiita.com/fmy/items/b92254d14049996f6ec3
  peco-pt-vim () {
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
  alias v='vim PECO'

  # ps with peco
  psp() {
    if [[ $# = 0 ]]; then
      ps -ef | peco
    else
      ps -ef | peco --query "$*"
    fi
  }
fi
