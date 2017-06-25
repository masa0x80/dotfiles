function cask_update
  set -l caskroom_dir /usr/local/Caskroom

  for pkg in $argv
    echo $caskroom_dir/$pkg | read -l app_dir
    set -l latest_version (brew cask info $pkg | grep "$pkg:" | cut -d ' ' -f 2)
    if not test -d $app_dir/$latest_version
      brew cask reinstall $pkg
    else
      echo "INFO: $color_green$pkg$color_normal already updated"
    end
  end
end
