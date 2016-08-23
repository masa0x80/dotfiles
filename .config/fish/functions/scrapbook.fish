function scrapbook
  if type -qa fzf; and type -qa mdv; and test -e $SCRAPBOOK_DIR
    set -q $SCRAPBOOK_DIR; and set -x SCRAPBOOK_DIR $HOME/.scrapbook
    find $SCRAPBOOK_DIR -type f | fzf --query "$argv" | read -l selected_line
    if not set -q $selected_line
      mdv $selected_line
    end
    commandline -f repaint
  end
end
