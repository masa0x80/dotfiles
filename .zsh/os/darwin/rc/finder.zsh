show-hidden-files() {
  defaults write com.apple.finder AppleShowAllFiles true && killall Finder
}

hide-hidden-files() {
  defaults write com.apple.finder AppleShowAllFiles false && killall Finder
}
