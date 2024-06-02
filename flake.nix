{
  description = "Vinegar Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { self, nixpkgs, home-manager, hyprland, sops-nix, nur, ... }@inputs:
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
        { nixpkgs.overlays = [ nur.overlay ]; }
        ({ pkgs, ... }:
          let 
            nur-no-pkgs = import nur {
              nurpkgs = import nixpkgs { system = "x86_64-linux"; };
            };
          in {
            imports = [ nur-no-pkgs.repos.iopq.modules.xraya  ];
            services.xraya.enable = true;
          })
        ./hosts/default/configuration.nix
        sops-nix.nixosModules.sops
        nur.nixosModules.nur
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
