# NOTE: Use preloaded path
set PATH $_PATH

# NOTE: must place after adding `/usr/local/bin` to PATH
export SHELL=(which fish)

# Environment Variables for fish {{{

# Disable greeting
set fish_greeting
set fish_prompt_pwd_dir_length 0

# Colors {{{
set fish_pager_color_completion grey
export fish_color_command=cyan

export ANGLER_QUERY_OPTION='--no-sort --query'
# }}}

# Set config path for gabbr
export gabbr_config=$HOME/.config/fish/gabbr.conf

# }}}
