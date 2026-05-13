{ pkgs, lib, ... }:

let
  localDir = builtins.getEnv "DOTFILES_LOCAL_DIR";
  hasLocal = localDir != "" && builtins.pathExists "${localDir}/nix/home.nix";
in
{
  imports = lib.optionals hasLocal [
    "${localDir}/nix/darwin.nix"
  ];

  # Nix is managed by Determinate Systems installer
  nix.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System-level packages
  environment.systemPackages = with pkgs; [
    # Build tools
    autoconf
    automake
    cmake
    pkg-config

    # Libraries
    boost
    gdbm
    gettext
    libgit2
    libsodium
    libyaml
    openssl

    # LLVM
    llvm
  ];

  # Homebrew
  homebrew = {
    enable = true;
    onActivation.upgrade = true;

    taps = [
      "ryooooooga/tap"
      "daipeihust/tap"
      "use-tusk/tap"
      "hanasuke/moralerspace"
      "masa0x80/tap"
    ];

    brews = [
      "mas"
      "ical-buddy"
      "totp-cli"
      "zabrze"
      "im-select"
    ];

    casks = [
      "1password"
      "alt-tab"
      "altair-graphql-client"
      "audacity"
      "box-drive"
      "cleanshot"
      "deskpad"
      "devtoys"
      "docker-desktop"
      "figma"
      "finicky"
      "gcloud-cli"
      "ghostty"
      "itsycal"
      "jordanbaird-ice"
      "karabiner-elements"
      "keycastr"
      "obs"
      "obsidian"
      "raycast"
      "rectangle"
      "slack"
      "wezterm"
      "visual-studio-code"
      "vlc"

      "google-chrome"
      "vivaldi"
      "microsoft-edge"

      "font-biz-udpgothic"
      "font-udev-gothic-nf"

      "font-0xproto-nerd-font"

      "font-monaspace"
      "hanasuke/moralerspace/font-moralerspace"

      "masa0x80/tap/font-pending-mono-hwnf"

      "tonisives/tap/ovim"
    ];

    masApps = {
      "Hand Mirror" = 1502839586;
      "Onedrive" = 823766827;
      "Screen Cursor" = 1577211880;
      "ScreenPointer" = 1368204906;
      "Xcode" = 497799835;
    };
  };

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.7;
    };

    screencapture = {
      location = "~/ScreenShots";
      type = "png";
    };

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      _FXSortFoldersFirst = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 9;
      KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      NSWindowShouldDragOnGesture = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
    };

    trackpad = {
      Clicking = false;
      Dragging = false;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
      TrackpadThreeFingerTapGesture = 0;
    };

    CustomUserPreferences = {
      "com.apple.AppleMultitouchTrackpad" = {
        TrackpadFiveFingerPinchGesture = 2;
        TrackpadFourFingerHorizSwipeGesture = 2;
        TrackpadFourFingerPinchGesture = 2;
        TrackpadFourFingerVertSwipeGesture = 2;
        TrackpadThreeFingerHorizSwipeGesture = 2;
        TrackpadThreeFingerVertSwipeGesture = 2;
        TrackpadTwoFingerDoubleTapGesture = 1;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
        ActuationStrength = 0;
      };
      NSGlobalDomain = {
        AppleLanguage = [
          "en"
          "ja"
        ];
        "com.apple.trackpad.scaling" = "3";
      };
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.screencapture" = {
        name = "ScreenShot";
        show-thumbnail = false;
      };
      "com.microsoft.VSCode" = {
        ApplePressAndHoldEnabled = false;
      };
      "com.microsoft.Outlook" = {
        NSUserKeyEquivalents = {
          "Clear Formatting" = "@l";
        };
      };
    };
  };

  # Activation scripts
  system.activationScripts.postActivation.text = ''
    # Disable Shortcuts for spotlight
    # ref. https://qiita.com/ry0f/items/f2c75f0a77b1012182d6
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>49</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>"

    # Change "Move focus to next window" shortcut to `Alt + Tab`
    /usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:27" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>48</integer><integer>524288</integer></array><key>type</key><string>standard</string></dict></dict>"
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Enable touch ID for sudo
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true; # for tmux
  };

  # Used for backwards compatibility
  system.stateVersion = 6;
}
