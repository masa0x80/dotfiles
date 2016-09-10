function __tmux_window_name
  if git rev-parse --is-inside-work-tree >/dev/null ^/dev/null
    pushd .
    set -l git_root (cd (echo -s (pwd) / (git rev-parse --show-cdup)); and pwd)
    popd
    echo "$git_root" | string split -r -m 2 '/' | grep -v '/' | string join '/'
  else
    prompt_pwd | string split -r -m 2 '/' | grep -v '/' | string join '/'
  end
end
