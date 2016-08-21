function select-vagrant-host
  find nodes | \
        grep vagrant | \
        fzf -1 | \
        sed -E 's/nodes\/(.*).json/vagrant@\1/' | \
        read -gx vagrant_host

  if test -n "$argv"
    eval "$argv $vagrant_host"
  end
  commandline -f repaint
end
