## ref: http://shibayu36.hatenablog.com/entry/2014/07/26/151106
function git_recent_all_branches
  commandline | read -l buffer
  git for-each-ref --format='%(refname)' --sort=-committerdate | \
        sed -e 's|^refs/\(heads\|remotes\)/||' | \
        fzf | read -l selected_branch
  if test -n "$selected_branch"
    if test -n "$buffer"
      commandline -a $selected_branch
    else
      commandline "git checkout -t $selected_branch"
      commandline -f execute
    end
  end
  commandline -f repaint
end
