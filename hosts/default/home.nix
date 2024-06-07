# [[file:../../README.org::*Main File: home.nix][Main File: home.nix:1]]
{ config, pkgs, lib, inputs, username, defaultEditor, ... }:
{
# Main File: home.nix:1 ends here

# [[file:../../README.org::*Imports][Imports:1]]
imports = [
# Imports:1 ends here

# [[file:../../README.org::*Tencent Meeting][Tencent Meeting:1]]
# ../../builds/tencent-meeting/default.nix
# Tencent Meeting:1 ends here

# [[file:../../README.org::*Syncthing Changed; test][Syncthing Changed; test:1]]
# ../../modules/home-manager/syncthing-package-definition.nix
# Syncthing Changed; test:1 ends here

# [[file:../../README.org::*Scripts][Scripts:1]]
../../modules/home-manager/scripts.nix
# Scripts:1 ends here

# [[file:../../README.org::*Neomutt][Neomutt:1]]
#../../modules/home-manager/neomutt.nix
# Neomutt:1 ends here

# [[file:../../README.org::*Shell][Shell:1]]
../../modules/home-manager/nushell.nix
# Shell:1 ends here

# [[file:../../README.org::*Editors][Editors:1]]
../../modules/home-manager/nixvim.nix
../../modules/home-manager/emacs.nix
# Editors:1 ends here

# [[file:../../README.org::*CLI Utilities][CLI Utilities:1]]
../../modules/home-manager/bottom.nix
../../modules/home-manager/git.nix
# CLI Utilities:1 ends here

# [[file:../../README.org::*Desktop][Desktop:1]]
../../modules/home-manager/hyprland.nix
../../modules/home-manager/mako.nix
../../modules/home-manager/waybar.nix
../../modules/home-manager/wlogout.nix
# Desktop:1 ends here

# [[file:../../README.org::*Browsers][Browsers:1]]
../../modules/home-manager/browsers.nix
# Browsers:1 ends here

# [[file:../../README.org::*Terminal][Terminal:1]]
../../modules/home-manager/kitty.nix
../../modules/home-manager/lf.nix
# Terminal:1 ends here

# [[file:../../README.org::*Nix Colors][Nix Colors:1]]
inputs.nix-colors.homeManagerModules.default
../../modules/home-manager/colors.nix
# Nix Colors:1 ends here

# [[file:../../README.org::*Fonts][Fonts:1]]
../../modules/home-manager/fonts.nix
# Fonts:1 ends here

# [[file:../../README.org::*Closing Bracket][Closing Bracket:1]]
];
# Closing Bracket:1 ends here

# [[file:../../README.org::*Home Manager Variables][Home Manager Variables:1]]
home.username = "${username}";
home.homeDirectory = "/home/${username}";
# Home Manager Variables:1 ends here

# [[file:../../README.org::*fd][fd:1]]
programs.fd = {
  enable = true;
  hidden = true; # Pass --hidden flag by default
  ignores = [ # globally ignore given paths
    ".git/"
    "*.bak"
  ];
};
# fd:1 ends here

# [[file:../../README.org::*thefuck][thefuck:1]]
programs.thefuck = {
  enable = true;
  enableNushellIntegration = true;
};
# thefuck:1 ends here

# [[file:../../README.org::*pandoc][pandoc:1]]
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
# pandoc:1 ends here

# [[file:../../README.org::*ripgrep][ripgrep:1]]
programs.ripgrep = {
  enable = true;
  arguments = [
    "--max-columns-preview"
    "--colors=line:style:bold"
  ];
};
# ripgrep:1 ends here

# [[file:../../README.org::*dconf][dconf:1]]
dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};
# dconf:1 ends here

# [[file:../../README.org::*Packages][Packages:1]]
home.packages = with pkgs; [
# Packages:1 ends here

# [[file:../../README.org::*Still to Sort][Still to Sort:1]]
# nur.repos.linyinfeng.wemeet
calibre # Open port 8080 for server
syncthing
libreoffice
bat
bc
brightnessctl
brightnessctl
bun
# csslint
stylelint
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
p7zip
pylint
python3Full
slurp
swappy
swaylock
swww
syncthing
taskwarrior3
wayshot
wf-recorder
wl-clipboard
wl-gammactl
wofi
wttrbar
xdotool
yad
# Still to Sort:1 ends here

# [[file:../../README.org::*Candy][Candy:1]]
pokeget-rs
macchina
# Candy:1 ends here

# [[file:../../README.org::*Document Management][Document Management:1]]
texliveFull
zathura
# Document Management:1 ends here

# [[file:../../README.org::*CLI Utilities][CLI Utilities:1]]
gh
fdupes
fzf
killall
mpv
rsync
tldr
pamixer
pciutils
# CLI Utilities:1 ends here

# [[file:../../README.org::*Media][Media:1]]
grimblast
mpc-cli
ncmpcpp
nsxiv
playerctl
# Media:1 ends here

# [[file:../../README.org::*Overrides][Overrides:1]]
# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
# Overrides:1 ends here

# [[file:../../README.org::*Closing bracket][Closing bracket:1]]
];
# Closing bracket:1 ends here

# [[file:../../README.org::*State Version][State Version:1]]
home.stateVersion = "23.11";
# State Version:1 ends here

# [[file:../../README.org::*Config Files Created by home.nix][Config Files Created by home.nix:1]]
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

#   ".config/nixpkgs/config.nix".text = ''
# {
#   packageOverrides = pkgs: {
#     nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
#       inherit pkgs;
#     };
#   };
# }
#   '';

};
# Config Files Created by home.nix:1 ends here

# [[file:../../README.org::*Session Variables][Session Variables:1]]
home.sessionVariables = {
  EDITOR = "${defaultEditor}";
};
# Session Variables:1 ends here

# [[file:../../README.org::*Let Home Manager install and manage itself][Let Home Manager install and manage itself:1]]
programs.home-manager.enable = true;
# Let Home Manager install and manage itself:1 ends here

# [[file:../../README.org::*Home-Manager][Home-Manager:1]]
# home-manager.backupFileExtension = "backup";
# Home-Manager:1 ends here

# [[file:../../README.org::*Closing][Closing:1]]
}
# Closing:1 ends here
