function __tmux_window_name
  pwd | string split -r -m 2 '/' | grep -v '/' | string join '/'
end
