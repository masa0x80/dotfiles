if [ -r $HOME/.zplug/zplug ]; then
  if type fzf > /dev/null 2>&1; then
    zstyle ":anyframe:selector:" use fzf
  fi

  # git branch
  bindkey '^gb'  anyframe-widget-checkout-git-branch
  bindkey '^g^b' anyframe-widget-checkout-git-branch
  bindkey '^gB' anyframe-widget-insert-git-branch
fi

if type fzf > /dev/null 2>&1; then
  bindkey '^Q' fzf-file-widget

  # git-add with peco
  # ref: http://petitviolet.hatenablog.com/entry/20140722/1406034439
  function peco-git-add() {
    local SELECTED_FILE_TO_ADD="$(git status --porcelain  | \
                                  fzf --query "$LBUFFER" | \
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

  function peco-git-recent-all-branches() {
    local SELECTED_BRANCH="$(git for-each-ref --format='%(refname)' --sort=-committerdate | \
                             sed -e 's|^refs/\(heads\|remotes\)/||'                       | \
                             fzf)"
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
fi
