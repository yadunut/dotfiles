{
  description = "Configuration of my systems";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }: {
    homeConfigurations."yadunut@yadunut-mbp" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [ ./yadunut-mbp/home.nix  ./modules/zsh.nix ./modules/neovim.nix ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
