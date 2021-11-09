#!/usr/bin/env fish

function __call_navi
    if test -n "$argv"
        navi --path .cheats.d/:(navi info cheats-path) --fzf-overrides --no-exact --print --query "$argv"
    else
        navi --path .cheats.d/:(navi info cheats-path) --fzf-overrides --no-exact --print
    end
end

function navi-widget -d "Show cheat sheets"
    __call_navi (commandline) | perl -pe 'chomp if eof' | read -lz result
    and commandline -- $result
    commandline -f repaint
end

bind \cg\t navi-widget
if bind -M insert >/dev/null 2>&1
    bind -M insert \cg\t navi-widget
end
