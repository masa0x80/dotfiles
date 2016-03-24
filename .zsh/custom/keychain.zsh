SSH_KEY_FILE=${SSH_KEY_FILE:-$HOME/.ssh/id_rsa}

if (( $+commands[keychain] )); then
  test -r $SSH_KEY_FILE && keychain -q $KEYCHAIN_OPTION $SSH_KEY_FILE
  source $HOME/.keychain/${HOST}-sh
fi
