function fish_user_key_bindings
  bind \c{ backward-word
  bind \c} forward-word

  bind \cs\cb scrapbook

  bind \cj execute
  bind \cm __execute_wrapper
  bind \r  __execute_wrapper

  bind '.' replace_multiple_dots
end
