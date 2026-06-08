{
  config,
  pkgs,
  lib,
  username,
  dotfilesDir,
  ...
}:

let
  localDir = builtins.getEnv "DOTFILES_LOCAL_DIR";
  hasLocal = localDir != "" && builtins.pathExists "${localDir}/nix/home.nix";
  mkSym = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = lib.optionals hasLocal [
    "${localDir}/nix/home.nix"
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.11";

  home.file = {
    ".bashrc".source = mkSym "${dotfilesDir}/.bashrc";
    ".bin".source = mkSym "${dotfilesDir}/.bin";
    ".cargo".source = mkSym "${dotfilesDir}/.cargo";
    ".config".source = mkSym "${dotfilesDir}/.config";
    ".curlrc".source = mkSym "${dotfilesDir}/.curlrc";
    ".default-cargo-crates".source = mkSym "${dotfilesDir}/.default-cargo-crates";
    ".default-gems".source = mkSym "${dotfilesDir}/.default-gems";
    ".default-go-packages".source = mkSym "${dotfilesDir}/.default-go-packages";
    ".default-npm-packages".source = mkSym "${dotfilesDir}/.default-npm-packages";
    ".default-python-packages".source = mkSym "${dotfilesDir}/.default-python-packages";
    ".direnvrc".source = mkSym "${dotfilesDir}/.direnvrc";
    ".editorconfig".source = mkSym "${dotfilesDir}/.editorconfig";
    ".editrc".source = mkSym "${dotfilesDir}/.editrc";
    ".gitmux.conf".source = mkSym "${dotfilesDir}/.gitmux.conf";
    ".homebrew".source = mkSym "${dotfilesDir}/.homebrew";
    ".irbrc".source = mkSym "${dotfilesDir}/.irbrc";
    ".myclirc".source = mkSym "${dotfilesDir}/.myclirc";
    ".npmrc".source = mkSym "${dotfilesDir}/.npmrc";
    ".prettierignore".source = mkSym "${dotfilesDir}/.prettierignore";
    ".textlintrc.yaml".source = mkSym "${dotfilesDir}/.textlintrc.yaml";
    ".tmux.conf".source = mkSym "${dotfilesDir}/.tmux.conf";
    ".zshenv".source = mkSym "${dotfilesDir}/.zshenv";
    ".zshrc".source = mkSym "${dotfilesDir}/.zshrc";
  };

  home.packages = with pkgs; [
    # Core utilities
    coreutils
    curl
    gnused
    gnutar
    gnugrep
    openssl
    sqlite
    gettext
    getopt
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
    jo
    catimg

    # Shell
    starship
    sheldon
    tmux
    lazygit
    direnv
    navi

    # Development tools
    mise
    protobuf
    graphviz
    imagemagick
    vhs
    jujutsu

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
    actionlint
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

    # Utilities
    gitmux
    gibo
    pass
    rage
    passage
    csvq
    markdownlint-cli2
    dyff

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
