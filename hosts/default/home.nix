# [[file:../../README.org::*Main File: home.nix][Main File: home.nix:1]]
{ config, pkgs, lib, inputs, username, defaultEditor, ... }:
{
# Main File: home.nix:1 ends here

# [[file:../../README.org::*Imports][Imports:1]]
imports = [
# Imports:1 ends here

# [[file:../../README.org::*Jurism][Jurism:1]]
# ../../builds/jurism.nix
# Jurism:1 ends here

# [[file:../../README.org::*Tencent Meeting][Tencent Meeting:1]]
# ../../builds/tencent-meeting/default.nix
# Tencent Meeting:1 ends here

# [[file:../../README.org::*Syncthing Changed; test][Syncthing Changed; test:1]]
# ../../modules/home-manager/syncthing-package-definition.nix
# Syncthing Changed; test:1 ends here

# [[file:../../README.org::*Scripts and Files][Scripts and Files:1]]
../../modules/home-manager/scripts.nix
# Scripts and Files:1 ends here

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
brightnessctl
bun
calibre # Open port 8080 for server
dart-sass
dbus
espanso-wayland
eww
glib
gnucash
hugo
inkscape
jq
keepassxc
kiwix
libnotify
libreoffice
minetest
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
wofi
wttrbar # weather
xdotool # useful with wayland?
yad # display GTK+ dialogs
# Still to Sort:1 ends here

# [[file:../../README.org::*Document Management][Document Management:1]]
texliveFull
zathura
zotero # citations
# Document Management:1 ends here

# [[file:../../README.org::*Non-GUI Things][Non-GUI Things:1]]
bat
bc
exfat
gh
fdupes
fzf
jmtpfs
killall
kitty
mpv
p7zip
pamixer
pciutils
pdf2svg
pylint
python3Full
rsync
stylelint
syncthing
tldr
transmission_4
wl-clipboard
wl-gammactl
# Non-GUI Things:1 ends here

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

# [[file:../../README.org::*Files Created by home.nix][Files Created by home.nix:1]]
# home.file = { ".config/espanso/configs/default.yml" =
#   { text =
#   ''
#   '';
#     executable = false;
#   };
#             };
# Files Created by home.nix:1 ends here

# [[file:../../README.org::*Config Files Created by home.nix][Config Files Created by home.nix:1]]
xdg.configFile = {
  ".config/espanso/configs/default.yml" = {
    target = "/espanso/configs/default.yml";
    enable = true;
    text =
      ''
      Test
        '';
    executable = false;
    onChange = ""; # shell command to run when file has changed between generations


  };
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
