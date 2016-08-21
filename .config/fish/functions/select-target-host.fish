function select-target-host
  find nodes | \
        grep json | \
        fzf -1 | \
        sed -E 's/nodes\/(.*).json/\1/' | \
        read -gx target_host

  if test -n "$argv"
    eval "$argv $target_host"
  end
  commandline -f repaint
end
