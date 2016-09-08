function __check_local_git_config
  if not test -f $HOME/.local_config/git/config
    set_color -o black
    set_color -b cyan
    echo -e '[WARN] Local git config file is not found.'
    set_color normal
  end
end
