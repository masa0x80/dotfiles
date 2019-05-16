# NOTE: must place after adding `/usr/local/bin` to PATH
export SHELL=(which fish)

# Environment Variables for fish {{{

# Disable greeting
set fish_greeting
set fish_prompt_pwd_dir_length 0

# Colors {{{
set fish_pager_color_completion grey
export fish_color_command=cyan
# }}}

### Prompt {{{

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

set __fish_git_prompt_char_dirtystate '⨯'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles 'u'
set __fish_git_prompt_char_stashstate 's'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# }}}

# Set fresco config
type -qa ghq && set -U fresco_root (ghq root)
set -U fresco_plugin_list_path $HOME/.config/fish/plugins.fish

# Set config path for gabbr
export gabbr_config=$HOME/.config/fish/gabbr.conf

# }}}
