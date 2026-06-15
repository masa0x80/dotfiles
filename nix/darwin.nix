{
  pkgs,
  lib,
  username,
  ...
}:

let
  localDir = builtins.getEnv "DOTFILES_LOCAL_DIR";
  hasLocal = localDir != "" && builtins.pathExists "${localDir}/nix/home.nix";
  httpProxy = builtins.getEnv "http_proxy";
  proxyEnv = lib.optionalAttrs (httpProxy != "") {
    http_proxy = httpProxy;
    https_proxy = httpProxy;
  };
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
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
      extraFlags = [ "--force" ];
      extraEnv = {
        HOMEBREW_NO_REQUIRE_TAP_TRUST = "1";
      }
      // proxyEnv;
    };

    taps = [
      "daipeihust/tap"
      "hanasuke/moralerspace"
      "ryooooooga/tap"
      "tonisives/tap"
    ];

    brews = [
      "mas"
      "ical-buddy"
      "totp-cli"
      "zabrze"
      "im-select"
    ];

    casks = [
      "altair-graphql-client"
      "1password"
      "alt-tab"
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
      "karabiner-elements"
      "keycastr"
      "obsidian"
      "onedrive"
      "raycast"
      "rectangle"
      "slack"
      "thaw"
      "wezterm"
      "visual-studio-code"

      "google-chrome"
      "vivaldi"
      "microsoft-edge"

      "font-biz-udpgothic"
      "font-udev-gothic-nf"

      "font-0xproto-nerd-font"

      "font-monaspace"
      "hanasuke/moralerspace/font-moralerspace"

      "tonisives/tap/ovim"
    ];

    masApps = {
      "Xcode" = 497799835;
    };
  };

  # macOS system defaults
  # ref. https://github.com/nix-darwin/nix-darwin/tree/master/modules/system/defaults/
  system.defaults = {
    menuExtraClock = {
      IsAnalog = true;
      Show24Hour = true;
      ShowSeconds = true;
    };

    dock = {
      # Dockのアイコンサイズ
      tilesize = 64;
      # Dockの自動非表示
      autohide = true;
      # アプリ起動時のアニメーション
      launchanim = true;
      # 起動中アプリのインジケーターを表示
      show-process-indicators = true;
      # 最近使ったアプリをDockに表示
      show-recents = false;
      # 4本指スプレッドでデスクトップ表示
      showDesktopGestureEnabled = true;
      # 4本指上下スワイプでMission Control
      showMissionControlGestureEnabled = true;
      # App Exposéジェスチャー
      showAppExposeGestureEnabled = false;
      # Launchpadジェスチャー
      showLaunchpadGestureEnabled = false;
    };

    trackpad = {
      # タップでクリック
      Clicking = true;
      # 2本指で右クリック
      TrackpadRightClick = true;
      TrackpadCornerSecondaryClick = 0;

      # 調べる＆データ検出
      ForceSuppressed = false;
      # 3本指タップでの調べるは無効
      TrackpadThreeFingerTapGesture = 0;

      # 静音クリック（0: 有効, 1: 無効）
      ActuationStrength = 0;
      FirstClickThreshold = 2;
      SecondClickThreshold = 2;

      # 拡大縮小 / スマートズーム / 回転
      TrackpadPinch = true;
      TrackpadTwoFingerDoubleTapGesture = true;
      TrackpadRotate = true;

      # ページ間スワイプ無効、フルスクリーン切替は4本指横スワイプ
      TrackpadThreeFingerHorizSwipeGesture = 0;
      TrackpadFourFingerHorizSwipeGesture = 2;

      # Mission Controlを4本指縦スワイプに割り当て
      TrackpadThreeFingerVertSwipeGesture = 0;
      TrackpadFourFingerVertSwipeGesture = 2;

      # 慣性スクロール
      TrackpadMomentumScroll = true;

      # 3本指ドラッグ
      Dragging = false;
      TrackpadThreeFingerDrag = false;
    };

    universalaccess = {
      mouseDriverCursorSize = 3.0;
    };

    finder = {
      # ソート時にフォルダを優先して表示
      _FXSortFoldersFirst = true;
      # タイトルバーにフルパス表示
      _FXShowPosixPathInTitle = true;
      # 隠しファイル表示
      AppleShowAllFiles = true;
      # 拡張子を表示
      AppleShowAllExtensions = true;
      # 拡張子変更の警告
      FXEnableExtensionChangeWarning = false;
      # finderの終了ができるように
      QuitMenuItem = true;
      # パスバーの有効化
      ShowPathbar = true;
      # ステータスバーの有効化
      ShowStatusBar = true;
    };

    NSGlobalDomain = {
      # 拡張子を常に表示
      AppleShowAllExtensions = true;
      # ナチュラルスクロール
      "com.apple.swipescrolldirection" = true;
      # ページ間スワイプを無効化
      AppleEnableSwipeNavigateWithScrolls = false;
      # 音量変更時の音
      "com.apple.sound.beep.feedback" = 0;
      # ダークモード
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      # キー長押し時のアクセント入力を有効化
      ApplePressAndHoldEnabled = false;
      # 調べる＆データ検出
      "com.apple.trackpad.forceClick" = false;
      "com.apple.trackpad.scaling" = 3.0;

      # キーリピート開始までの待ち時間
      InitialKeyRepeat = 9;
      # キーリピート速度（小さいほど速い）
      KeyRepeat = 1;

      # Cmd と Ctrl を押している時にのドラッグでウィンドウを移動できるように
      NSWindowShouldDragOnGesture = true;

      # 入力補助の自動置換系を無効化
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        AppleLanguage = [
          "en"
          "ja"
        ];
      };
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Spotlight検索を無効化
          "64" = {
            enabled = false;
          };
          # Finder検索ウィンドウを無効化
          "65" = {
            enabled = false;
          };
          # CleanShotを使用するためScreenshot and recording optionsを無効化
          "28" = {
            enabled = false;
          };
          "29" = {
            enabled = false;
          };
          "30" = {
            enabled = false;
          };
          "31" = {
            enabled = false;
          };
          "184" = {
            enabled = false;
          };
        };
      };
      "com.apple.finder" = {
        AppleShowAllFiles = true;
        ShowExternalHardDrivesOnDesktop = false;
        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
        _FXSortFoldersFirst = true;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.screencapture" = {
        name = "ScreenShot";
        show-thumbnail = false;
      };
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
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

    # macOS設定を再起動なしで即時反映する
    /usr/bin/sudo -u ${username} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Enable touch ID for sudo
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true; # for tmux
  };

  # Used for backwards compatibility
  system.stateVersion = 6;
}
