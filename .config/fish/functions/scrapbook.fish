function scrapbook
    if type -qa fzf
        set selected_files (find $SCRAPBOOK_DIR -type f | fzf -1 -q "$argv" | string escape -n)
        if test "$selected_files" != ''
            eval $EDITOR $selected_files
        end
    end
end
