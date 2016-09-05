## ref: http://shibayu36.hatenablog.com/entry/2014/07/26/151106
function __git_recent_all_branches
  commandline | read -l buffer
  git for-each-ref --format='%(refname)' --sort=-committerdate | \
        fzf | read -l selected_branch
  if test -n "$selected_branch"
    if test -n "$buffer"
      commandline -i (echo $selected_branch | sed -e 's|^refs\/heads\/||' -e 's|^refs\/remotes\/origin\/||')
    else
      commandline "git checkout -t $selected_branch"
      commandline -f execute
    end
  end
  commandline -f repaint
end
