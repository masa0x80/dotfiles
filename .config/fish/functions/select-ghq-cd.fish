function select-ghq-cd
  commandline | read -l buffer
  ghq list --full-path | \
        sed -e "s|$HOME/||g" | \
        fzf --query "$buffer" | \
        read -l repository_path
  if test -n "$repository_path"
    cd ~/(echo $repository_path | sed -e 's/ /\\ /g')
  end
  commandline -f repaint
end
