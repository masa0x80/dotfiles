# ref: http://motemen.hatenablog.com/entry/2015/07/mackerel-mkr-peco-zsh
function select_mkr_ip
  commandline | read -l buffer

  mkr-hosts-tsv | fzf --nth=2,3 --delimiter='\t' --query "$buffer" | read -l selected_line

  if test -n "$selected_line"
    set -l ip   (echo $selected_line | cut -f 1)
    set -l host (echo $selected_line | cut -f 2)
    commandline -a "$ip # $host"
  end
  commandline -f repaint
end
