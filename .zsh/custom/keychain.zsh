if (( $+commands[keychain] )); then
  keychain -q $KEYCHAIN_OPTION $SSH_KEY_FILE
  load_file $HOME/.keychain/${HOST}-sh
fi
