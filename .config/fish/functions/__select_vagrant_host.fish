function __select_vagrant_host
  find nodes | \
        grep vagrant | \
        fzf -1 --prompt='vagrant host> ' | \
        sed -E 's/nodes\/(.*).json/\1/'
end
