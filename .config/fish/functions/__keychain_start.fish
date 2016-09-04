function __keychain_start
  if type -qa keychain
    keychain -q $SSH_KEY_FILE; and __load_file $HOME/.keychain/(hostname)-fish
  end
end
