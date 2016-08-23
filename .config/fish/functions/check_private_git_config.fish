function check_private_git_config
  if not test -f $HOME/.private/git/config
    set_color -o black
    set_color -b cyan
    echo -e '[WARN] Private git config file is not found.'
    set_color normal
  end
end
