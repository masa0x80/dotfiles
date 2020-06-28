# Skip loading config if already login
if status is-login
    # Load OS settings
    for config_file in $HOME/.config/fish/conf.d/$UNAME_S/*
        source $config_file
    end

    # Append $DOTFILE/bin to $PATH
    # NOTE: must place before loading `$HOME/.config.local/fish/config.fish`
    not set -q DOTFILE && export DOTFILE=$HOME/.dotfiles
    if test -d $DOTFILE
        __add_fish_user_paths $DOTFILE/bin
    end

    # Load local configurations
    __load_file $HOME/.config.local/fish/config.fish
end

set SHELL (type -p fish)

### gabbr
not set -q global_abbreviations && gabbr -r

### Hooks {{{

function __fish_prompt_hooks --on-event fish_prompt
    # function __direnv_init --on-event fish_prompt
    type -qa direnv && eval (direnv export fish)

    # tmux auto rename
    if __tmux_is_running
        set -l tmux_current_window_id (tmux list-panes -aF '#{window_id}:#{pane_pid}' | grep :$fish_pid | cut -d: -f1)
        tmux rename-window -t $tmux_current_window_id (current_dir)(fish_git_prompt || echo '')
    end
end

# }}}
