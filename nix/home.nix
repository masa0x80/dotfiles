{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # Core utilities
    coreutils
    curl
    gnused
    gnutar
    gnugrep
    less
    rsync
    watch
    lsof

    # Git
    git
    hub
    ghq
    git-extras

    # CLI Tools
    bat
    eza
    fd
    delta
    difftastic
    ripgrep
    sd
    silicon
    grex
    rm-improved
    fzf
    xh
    yq
    jo
    catimg

    # Shell
    starship
    sheldon
    direnv
    navi

    # Development tools
    mise
    protobuf
    graphviz
    imagemagick
    vhs
    jj

    # Nix tools
    nixd
    nixfmt
    statix
    deadnix

    # LSP Servers
    bash-language-server
    clang-tools
    vscode-langservers-extracted
    jdt-language-server
    kotlin-language-server
    lua-language-server
    marksman
    solargraph
    tailwindcss-language-server
    terraform-ls
    typescript-language-server

    # Linters/Formatters
    black
    cspell
    (lib.meta.hiPrio gopls)
    gotools
    hadolint
    shellcheck
    shfmt
    stylua
    tflint
    oxlint

    # Database clients
    mariadb.client
    postgresql
    redis
    mycli
    pgcli

    # Container Tools
    lazydocker
    dive

    # Git TUI
    lazygit
    gitmux

    # Utilities
    gibo
    pass
    rage
    csvq
    markdownlint-cli2
    dyff
    terminal-notifier

    # Tools for macOS
    blueutil
    pinentry_mac
    pngpaste
  ];

  home.activation.createScreenshotDir = ''
    mkdir -p ~/ScreenShots
  '';

  programs.home-manager.enable = true;
}
