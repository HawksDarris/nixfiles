{
  description = "Vinegar Flakes";

  nixConfig = {
    trusted-substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    # nix.settings.substituters = lib.mkBefore [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];


    # extra-trusted-public-keys = [
    #   ""
    # ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11"; # required for neorg until it is fixed, but probably a good thing to have as a fallback regardless.

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

    # Vanilla nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neve nixvim
    # Neve = {
    #   url = "github:redyf/Neve";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
    pkgs-stable = import nixpkgs-stable {inherit system;}; # see neorg note above

    /* ---- UNFREE PACKAGES ---- */
    # Define the list of unfree packages to allow here, so you can pass it to
    # both `sudo nixos-rebuild` and `home-manager`
    allowed-unfree-packages = [
      # "obsidian"
      # "postman"
      # "vscode"
      # "vscode-extension-github-copilot"
      "wpsoffice"
      "wechat-uos"
      "corefonts"
    ];
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs username allowed-unfree-packages;};
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
          allowed-unfree-packages
          pkgs-stable
        ; };
      };
    };
  }
