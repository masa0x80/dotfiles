function fish_user_key_bindings
    bind \c{ backward-word
    bind \c} forward-word

    bind \cs\cb scrapbook

    bind ' ' '__gabbr_expand; commandline -i " "'
    bind ';' '__gabbr_expand; commandline -i "; "'
    bind \cj '__gabbr_expand; commandline -f execute'
    bind \cm '__gabbr_expand; __execute_wrapper'
    bind \r '__gabbr_expand; __execute_wrapper'
end
