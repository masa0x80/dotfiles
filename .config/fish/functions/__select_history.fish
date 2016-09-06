function __select_history
  commandline | read -l buffer
  history | fzf --no-sort --query "$buffer" | read -l command
  if test -n "$command"
    commandline $command
  end
  commandline -f repaint
end
