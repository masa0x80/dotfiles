function select-git-status
  git status -s -uno | \
        fzf | \
        cut -d ' ' -f 3 | \
        tr '\n' ' ' | \
        read -gx files

  if test -n "$argv"
    eval "$argv $files"
  end
  commandline -f repaint
end
