## ref: http://shibayu36.hatenablog.com/entry/2014/07/26/151106
function git_recent_branches
  commandline | read -l buffer
  git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        sed -e 's|^refs/heads/||' | \
        fzf | read -l selected_branch
  if test -n "$selected_branch"
    if test -n "$buffer"
      commandline -a $selected_branch
    else
      commandline "git checkout $selected_branch"
      commandline -f execute
    end
  end
  commandline -f repaint
end
