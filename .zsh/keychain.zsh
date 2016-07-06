if (( $+commands[keychain] )); then
  keychain -q $SSH_KEY_FILE
  load_file $HOME/.keychain/${HOST}-sh
fi

TRAPEXIT() {
  if [ $(ps | grep '[t]mux' | wc -l) -eq 0 ]; then
    keychain -q -k all
  fi
}
