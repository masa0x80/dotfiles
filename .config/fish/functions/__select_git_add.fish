function __select_git_add
  commandline | read -l buffer
  git status --porcelain | \
        fzf --query "$buffer" | \
        awk -v git_root=:/ '{print git_root$2}' | \
        tr '\n' ' ' | \
        read -l selected_files_to_add
  if test -n "$selected_files_to_add"
    commandline "git add $selected_files_to_add"
    commandline -f execute
  end
  commandline -f repaint
end
