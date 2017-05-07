function scrapbook
  if type -qa fzf; and type -qa mdv; and test -e $SCRAPBOOK_DIR
    set -q SCRAPBOOK_DIR; and set -x SCRAPBOOK_DIR $HOME/.scrapbook
    find $SCRAPBOOK_DIR -type f | fzf --query "$argv" | read -l selected_line
    if set -q selected_line
      commandline "mdv $selected_line"
    end
  end
end
