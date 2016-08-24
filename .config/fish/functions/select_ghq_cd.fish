function select_ghq_cd
  commandline | read -l buffer
  ghq list --full-path | \
        sed -e "s|$HOME/||g" | \
        fzf --query "$buffer" | \
        sed -e 's/ /\\\\ /g' | \
        read -l repository_path
  if test -n "$repository_path"
    commandline "cd ~/$repository_path"
    commandline -f execute
  end
  commandline -f repaint
end
