function __check_local_git_config
    if not test -f $HOME/.config.local/git/config
        set_color -o black
        set_color -b cyan
        echo -e '[WARN] Local git config file is not found. Create ~/.config.local/git/config file.'
        echo -e '       Check https://github.com/masa0x80/dotfiles#after-installation'
        set_color normal
    end
end
