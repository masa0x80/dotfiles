function __select_target_host
  find nodes | \
        grep json | \
        fzf -1 --prompt='target host> ' | \
        sed -E 's/nodes\/(.*).json/\1/'
end
