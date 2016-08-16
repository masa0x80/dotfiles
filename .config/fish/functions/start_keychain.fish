function start_keychain
  if type -a keychain > /dev/null
    keychain -q $SSH_KEY_FILE; and load_file $HOME/.keychain/(hostname)-fish
  end
end
