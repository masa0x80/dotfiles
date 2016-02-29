if (( $+commands[fzf] )); then
  bindkey '^Q' fzf-file-widget

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
