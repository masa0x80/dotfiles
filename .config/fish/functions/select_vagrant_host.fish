function select_vagrant_host
  find nodes | \
        grep vagrant | \
        fzf -1 | \
        sed -E 's/nodes\/(.*).json/vagrant@\1/'
end
