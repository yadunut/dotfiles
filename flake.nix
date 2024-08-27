{
  description = "Configuration of my systems";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, flake-utils, agenix, nixvim, ... }@inputs: {
    homeConfigurations = {
      "yadunut@yadunut-mbp" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = {
            allowUnfree = true;
          };
        };
        modules = [ ./yadunut-mbp/home.nix ];
      };
      "yadunut@yadunut-mba" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./yadunut-mba/home.nix
        ];
      };
  };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./falcon-nixos/configuration.nix
        agenix.nixosModules.default
        { _module.args = { inherit inputs; };}
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yadunut = import ./falcon-nixos/home.nix;
        }
      ];
    };
  };
}
