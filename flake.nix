{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs,  ... }@inputs: {
      system = "x86_64-linux";
      # TODO figure this nonsense out
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/default/configuration.nix
	  #./hosts/default/home.nix
          #inputs.home-manager.nixosModules.default
        ];
      };
  };
}
