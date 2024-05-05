{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
 
    imports =
      [
	../../modules/home-manager/git.nix
	../../modules/home-manager/hyprland.nix
	../../modules/home-manager/kitty.nix
	../../modules/home-manager/lf.nix
	../../modules/home-manager/nushell.nix
	../../modules/home-manager/waybar.nix
        ../../modules/home-manager/browsers.nix
        ../../modules/home-manager/fonts.nix
	inputs.nixvim.homeManagerModules.nixvim
      ];

  home.username = "sour";
  home.homeDirectory = "/home/sour";

  programs.nixvim = {
    plugins.lightline.enable = true;
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2;        # Tab width should be 2
    };
    extraConfigLua = ''
      -- Print a little welcome message when nvim is opened!
      print("Hello world!")
    '';
    extraConfigVim = ''
    '';
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
      neovim
      emacs 
      gh
      tldr
      fd
      nsxiv
      ripgrep
      bun 
      dart-sass
      rsync
      fzf

	# sound
  	pavucontrol
  	pamixer
  	brightnessctl
	mpc-cli
	ncmpcpp
	playerctl

	# To sort
	# lxqt-policykit-agent
	pandoc
	dbus
	pciutils
	libnotify
	ueberzug # for lf previews
	jq
	glib
	bat
	ncdu
	dunst
	mako # Maybe replace dunst
	kitty
	swww
	wlogout
	eww
	brightnessctl
	hyprpicker
	rofi-wayland
	rofimoji
	slurp
	swappy
	swaylock
	wf-recorder
	wl-gammactl
	wl-clipboard
	wofi
	wayshot
	xdotool

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # Didn't work for some reason. Will move to nushell.nix and see.
    # EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
