function select_git_status
  git status -s -uno | \
        fzf | \
        cut -d ' ' -f 3 | \
        tr '\n' ' '
end
