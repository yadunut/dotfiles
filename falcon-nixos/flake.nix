{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
         ./configuration.nix
	 agenix.nixosModules.default
	 { _module.args = { inherit inputs; };}
	 home-manager.nixosModules.home-manager
	 {
	   home-manager.useGlobalPkgs = true;
	   home-manager.useUserPackages = true;
	   home-manager.users.yadunut = import ./home.nix;
	 }
      ];
    };
  };
}
