function __select_target_host
  find nodes | \
        grep json | \
        fzf -1 | \
        sed -E 's/nodes\/(.*).json/\1/'
end
