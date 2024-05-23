{
  description = "Vinegar Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    nix-colors.url = "github:misterio77/nix-colors";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, hyprland, sops-nix, ... }@inputs:
  let
    /* ---- SYSTEM SETTINGS ---- */
    system = "x86_64-linux";
    hostname = "NixOS";
    pkgs = nixpkgs.legacyPackages.${system};

    /* ---- USER SETTINGS ---- */
    username = "sour";
    term = "kitty";
    defaultWebBrowser = "qutebrowser";
    defaultFileBrowser = "lf";
    defaultEditor = "nvim";
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        sops-nix.nixosModules.sops
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

        extraSpecialArgs = { 
          inherit 
          inputs 
          username
          term 
          defaultWebBrowser 
          defaultFileBrowser 
          defaultEditor 
        ; };
      };
    };
  }
