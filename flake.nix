{
  description = "masa's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # https://lazamar.co.uk/nix-versions/
    # nixpkgs-hoge.url = "github:NixOS/nixpkgs/${commit-hash}";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      # nixpkgs-hoge,
      ...
    }:
    let
      system = builtins.currentSystem;
      username =
        let
          sudoUser = builtins.getEnv "SUDO_USER";
          user = builtins.getEnv "USER";
        in
        if sudoUser != "" then
          sudoUser
        else if user != "" && user != "root" then
          user
        else
          throw "Cannot determine username. Run with sudo.";
      hostName =
        let
          name = builtins.getEnv "HOST";
        in
        if name != "" then
          name
        else
          throw "HOST environment variable is not set. Run with: sudo HOST=$HOST";
    in
    {
      darwinConfigurations.${hostName} = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit username;
        };
        modules = [
          ./nix/darwin.nix
          home-manager.darwinModules.home-manager
          {
            system.primaryUser = username;
            users.users.${username}.home = "/Users/${username}";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit username;
              dotfilesDir = builtins.getEnv "PWD";
            };
            home-manager.users.${username} = import ./nix/home.nix;
          }
        ];
      };
    };
}
