function fish_user_key_bindings
    bind \cg\ch backward-word
    bind \cg\cl forward-word

    bind \cs\cb scrapbook
    bind \cg\t snippet

    bind \cg\cb __switch_or_insert_git_select_local_branch

    bind ' ' '__gabbr_expand; commandline -i " "'
    bind ';' '__gabbr_expand; commandline -i ";"'
    bind \cj '__gabbr_expand; commandline -f execute'
    bind \cm '__gabbr_expand; commandline -f execute'
    bind \r '__gabbr_expand; commandline -f execute'
end
