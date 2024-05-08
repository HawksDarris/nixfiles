{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
  let
    /* ---- SYSTEM SETTINGS ---- */
    system = "x86_64-linux";
    hostname = "NixOS";
    pkgs = nixpkgs.legacyPackages.${system};

    /* ---- USER SETTINGS ---- */
    username = "sour";

  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
          #./modules/nixos/locale.nix
          #./hosts/default/home.nix
          #inputs.home-manager.nixosModules.default
        ];
      };
      homeConfigurations."sour" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./hosts/default/home.nix
          hyprland.homeManagerModules.default
          {wayland.windowManager.hyprland.enable = true;}
        ];

        extraSpecialArgs = { inherit inputs username; };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
  }
