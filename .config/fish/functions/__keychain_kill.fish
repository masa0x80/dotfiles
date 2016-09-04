function __keychain_kill
  if test (ps | command grep '[t]mux' | wc -l) -eq 0
    keychain -q -k all
  end
end
