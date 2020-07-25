function scrapbook
    if type -qa fzf
        set selected_files (files (scrapbook_dir "$argv") | fzf -1 | string unescape | string escape -n)
        if test "$selected_files" != ''
            eval $EDITOR $selected_files
        end
    end
end
