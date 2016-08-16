function kill_keychain
  if test (ps | command grep '[t]mux' | wc -l) -eq 0
    keychain -q -k all
  end
end
