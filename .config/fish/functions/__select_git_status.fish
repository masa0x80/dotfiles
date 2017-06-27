function __select_git_status
    git status -s -uno | fzf --prompt='GST> ' | awk '{print $2}' | tr '\n' ' '
end
