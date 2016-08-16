function show-hidden-files
  defaults write com.apple.finder AppleShowAllFiles true; and killall Finder
end

function hide-hidden-files
  defaults write com.apple.finder AppleShowAllFiles false; and killall Finder
end
