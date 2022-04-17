(( ! ${+commands[exa]} )) && return 1

export EXA_COLORS='da=1;34:gm=1;34'

alias ls='exa --group-directories-first --icons'
abbr -S -q l='ls -a'
abbr -S -q ll='ls -l --git'
abbr -S -q la='ls -la --git'
abbr -S -q tree='exa -T --icons'
