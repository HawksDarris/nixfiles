{ config, pkgs, lib, inputs, username, ... }:

{
imports =
  [
    inputs.nix-colors.homeManagerModules.default
    # ../../modules/home-manager/neomutt.nix
    ../../modules/home-manager/bottom.nix
    ../../modules/home-manager/browsers.nix
    ../../modules/home-manager/colors.nix
    ../../modules/home-manager/fonts.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/lf.nix
    ../../modules/home-manager/mako.nix
    ../../modules/home-manager/nixvim/nixvim.nix
    ../../modules/home-manager/nushell.nix
    ../../modules/home-manager/scripts.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/wlogout.nix
  ];

  # TODO replace username with variable
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

    # We have to force the values below to override the ones defined above
  specialisation.light-theme.configuration = {
    colorScheme = lib.mkForce { 
      slug =  "catppuccinLatte";
      colors = {
        base00 = "#eff1f5";
        base01 = "#e6e9ef";
        base02 = "#ccd0da";
        base03 = "#bcc0cc";
        base04 = "#acb0be";
        base05 = "#4c4f69";
        base06 = "#dc8a78";
        base07 = "#7287fd";
        base08 = "#d20f39";
        base09 = "#fe640b";
        base0A = "#df8e1d";
        base0B = "#40a02b";
        base0C = "#179299";
        base0D = "#1e66f5";
        base0E = "#8839ef";
        base0F = "#dd7878";
      };
    };
  };

  programs.pywal.enable = true;
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
        revealjs-url = "..";
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
  (hiPrio (writeShellApplication {
      name = "toggle-theme";
      runtimeInputs = with pkgs; [ home-manager coreutils ripgrep ];
        # go back two generations
        # home-manager creates a new generation every time activation script invoked
        text = ''
          "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate
          '';
      }
    )
  )

  gnucash
  emacs 
  bun 
  dart-sass
  yad
  keepassxc
  wttrbar
  taskwarrior3

  # media
  grimblast
  mpc-cli
  ncmpcpp
  nsxiv
  playerctl

  # file management
  jmtpfs # for phone mounting

  # cli things
  gh
  fdupes
  fzf
  killall
  mpv
  rsync
  tldr
  pamixer
  pciutils

  # document management
  texliveFull
  zathura

  # Candy
  pokeget-rs

  # To sort
  kiwix
  brightnessctl
  # lxqt-policykit-agent
  dbus
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
