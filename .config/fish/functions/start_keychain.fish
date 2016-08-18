function start_keychain
  if type -qa keychain
    keychain -q $SSH_KEY_FILE; and load_file $HOME/.keychain/(hostname)-fish
  end
end
