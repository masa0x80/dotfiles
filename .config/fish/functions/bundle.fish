function bundle
  set -l t_window (tmux list-windows | command grep -E '\(active\)$' | cut -d ':' -f1)
  set -l t_pane   (tmux list-pane    | command grep -E '\(active\)$' | cut -d ':' -f1)
  command bundle $argv
  if string match -q $argv[1] 'install'
    if type -qa gtags; and type -qa cpulimit; and type -qa tmux
      set -l pid %self
      set -l log_file /tmp/gtags-$pid
      echo
      set_color magenta;
      echo gtags error log: $log_file
      echo
      tmux split-window -t ":$t_window.$t_pane" -v -l 1 "tmux select-pane -t :.-; cpulimit -i -l 30 gtags -v 2>&1 | tee $log_file"
    end
  end
end
