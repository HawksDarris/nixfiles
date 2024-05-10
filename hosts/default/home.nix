{ config, pkgs, inputs, username, ... }:

{
imports =
  [
    inputs.nix-colors.homeManagerModules.default
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/mako.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/lf.nix
    # ../../modules/home-manager/neomutt.nix
    ../../modules/home-manager/nushell.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/browsers.nix
    ../../modules/home-manager/fonts.nix
    ../../modules/home-manager/nixvim/nixvim.nix
    ../../modules/home-manager/scripts.nix
    ../../modules/home-manager/wlogout.nix
  ];

  # TODO replace username with variable
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  # TODO Modularize
  # colorScheme = {
  #   slug = "icyblue";
  #   name = "Icyblue";
  #   author = "Gabriel Fontes (https://github.com/Misterio77)";
  #   palette = {
  #     base00 = "#271C3A";
  #     base01 = "#100323";
  #     base02 = "#3E2D5C";
  #     base03 = "#5D5766";
  #     base04 = "#BEBCBF";
  #     base05 = "#DEDCDF";
  #     base06 = "#EDEAEF";
  #     base07 = "#BBAADD";
  #     base08 = "#A92258";
  #     base09 = "#918889";
  #     base0A = "#804ead";
  #     base0B = "#C6914B";
  #     base0C = "#7263AA";
  #     base0D = "#8E7DC6";
  #     base0E = "#953B9D";
  #     base0F = "#59325C";
  #   };
  # };

  # fd
  programs.fd = {
    enable = true;
    hidden = true; # Pass --hidden flag by default
    ignores = [ # globally ignore given paths
      ".git/"
      "*.bak"
    ];
  };

  # thefuck
  programs.thefuck = {
    enable = true;
    enableNushellIntegration = true;
  };

  # ripgrep
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };

  # pandoc
  programs.pandoc = {
    enable = true;
    citationStyles = [ # list of paths to .csl files
    ];
    defaults = {
      metadata = {
        author = "John Doe";
      };
      pdf-engine = "xelatex";
      citeproc = true; # What is citeproc? I forget.
    };
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
  emacs 
  gh
  grimblast
  tldr
  fdupes
  nsxiv
  texliveFull
  bun 
  dart-sass
  rsync
  fzf
  bottom
  mpv
  yad
  killall
  wttrbar
  zathura

  # sound
  pavucontrol
  pamixer
  brightnessctl
  mpc-cli
  ncmpcpp
  playerctl

  # To sort
  # lxqt-policykit-agent
  pokeget-rs
  dbus
  pciutils
  libnotify
  ueberzug # for lf previews
  jq
  glib
  bat
  ncdu
  kitty
  swww
  eww
  brightnessctl
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
