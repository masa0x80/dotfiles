function scrapbook
    not set -q SCRAPBOOK_DIR && set -gx SCRAPBOOK_DIR $HOME/.scrapbook
    if type -qa fzf
        and test -e $SCRAPBOOK_DIR
        set -q SCRAPBOOK_DIR
        and set -x SCRAPBOOK_DIR $HOME/.scrapbook
        set selected_files (files $SCRAPBOOK_DIR | fzf -1 -q "$argv" | string unescape | string escape -n)
        if set -q selected_files
            eval $EDITOR $selected_files
        end
    end
end
