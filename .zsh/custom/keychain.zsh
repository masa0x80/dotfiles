if (( $+commands[keychain] )); then
  test -r ${SSH_KEY_FILE:=$HOME/.ssh/id_rsa} && keychain -q $KEYCHAIN_OPTION $SSH_KEY_FILE
  load_file $HOME/.keychain/${HOST}-sh
fi
