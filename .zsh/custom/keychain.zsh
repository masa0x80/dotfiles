if (( $+commands[keychain] )); then
  eval `keychain -q --eval --agents ssh $SSH_KEY_FILE`
fi

TRAPEXIT() {
  if [ $(ps -ef | grep '[t]mux' | wc -l) -eq 0 ]; then
    keychain -k all
  fi
}
