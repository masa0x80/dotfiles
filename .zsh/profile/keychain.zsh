if (( $+commands[keychain] )); then
  eval `keychain -q --eval --agents ssh $KEYCHAIN_OPTION $SSH_KEY_FILE`
fi

TRAPEXIT() {
  if [ $(ps | grep '[t]mux' | wc -l) -eq 0 ]; then
    keychain -q -k all
  fi
}
