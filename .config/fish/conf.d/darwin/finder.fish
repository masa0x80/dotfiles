function show_hidden_files
    defaults write com.apple.finder AppleShowAllFiles true
    and killall Finder
end

function hide_hidden_files
    defaults write com.apple.finder AppleShowAllFiles false
    and killall Finder
end
