{ config, pkgs, lib, inputs, username, defaultEditor, ... }:
{

imports = [

../../modules/home-manager/scripts.nix

#../../modules/home-manager/neomutt.nix

../../modules/home-manager/nushell.nix

../../modules/home-manager/nixvim.nix
../../modules/home-manager/emacs.nix

../../modules/home-manager/bottom.nix
../../modules/home-manager/git.nix

../../modules/home-manager/hyprland.nix
../../modules/home-manager/mako.nix
../../modules/home-manager/waybar.nix
../../modules/home-manager/wlogout.nix

../../modules/home-manager/browsers.nix

../../modules/home-manager/kitty.nix
../../modules/home-manager/lf.nix

inputs.nix-colors.homeManagerModules.default
../../modules/home-manager/colors.nix

../../modules/home-manager/fonts.nix

];

home.username = "${username}";
home.homeDirectory = "/home/${username}";

programs.fd = {
  enable = true;
  hidden = true; # Pass --hidden flag by default
  ignores = [ # globally ignore given paths
    ".git/"
    "*.bak"
  ];
};

programs.thefuck = {
  enable = true;
  enableNushellIntegration = true;
};

programs.pandoc = {
  enable = true;
  citationStyles = [ # list of paths to .csl files
  ];
  defaults = {
    metadata = {
      revealjs-url = "..";
    };
    pdf-engine = "xelatex";
    citeproc = true; # Generates citations and bibliography from CSL
  };
};

programs.ripgrep = {
  enable = true;
  arguments = [
    "--max-columns-preview"
    "--colors=line:style:bold"
  ];
};

home.packages = with pkgs; [

bat
bc
brightnessctl
brightnessctl
bun
dart-sass
dbus
exfat
eww
glib
gnucash
hugo
jmtpfs
jq
keepassxc
kitty
kiwix
libnotify
ncdu
rofi-wayland
rofimoji
slurp
swappy
swaylock
swww
taskwarrior3
wayshot
wf-recorder
wl-clipboard
wl-gammactl
wofi
wttrbar
yad

pokeget-rs
macchina

texliveFull
zathura

gh
fdupes
fzf
killall
mpv
rsync
tldr
pamixer
pciutils

grimblast
mpc-cli
ncmpcpp
nsxiv
playerctl

# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

];

home.stateVersion = "23.11";

home.file = {
  # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
};

home.sessionVariables = {
  EDITOR = "${defaultEditor}";
};

programs.home-manager.enable = true;

}
