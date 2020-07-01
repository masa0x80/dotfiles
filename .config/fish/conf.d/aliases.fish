if type -qa exa
    alias l='exa'
    alias la='exa -la'
    alias ll='exa -l'
    abbr -a tree 'exa -T'
else
    alias l='ls'
    alias la='ls -lAh'
    alias ll='ls -lh'
end
