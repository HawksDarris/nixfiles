# [[file:../../README.org::*Main File: home.nix][Main File: home.nix:1]]
{ config, pkgs, lib, inputs, username, defaultEditor, ... }:
{
# Main File: home.nix:1 ends here

# [[file:../../README.org::*Imports][Imports:1]]
imports = [
# Imports:1 ends here

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

# [[file:../../README.org::*Services][Services:1]]
{ ... }:
{
# Services:1 ends here

# [[file:../../README.org::*Emacs][Emacs:1]]
services.emacs.client.enable = true;
# Emacs:1 ends here

# [[file:../../README.org::*Closing][Closing:1]]
}
# Closing:1 ends here

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

# [[file:../../README.org::*Packages][Packages:1]]
home.packages = with pkgs; [
# Packages:1 ends here

# [[file:../../README.org::*Still to Sort][Still to Sort:1]]
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

# [[file:../../README.org::*Shell Scripts][Shell Scripts:1]]
{ pkgs, ... }:
{
  home.packages = with pkgs; [
# Shell Scripts:1 ends here

# [[file:../../README.org::*compiler script][compiler script:1]]
(pkgs.writeShellScriptBin "compiler"
  ''
#!/bin/sh

file=$(readlink -f "$1")
dir=''${file%/*}
base="''${file%.*}"
ext="''${file##*.}"

cd "$dir" || exit 1

textype() { \
textarget="$(getcomproot "$file" || echo "$file")"
echo "$textarget"
command="pdflatex"
( head -n5 "$textarget" | grep -qi 'xelatex' ) && command="xelatex"
$command --output-directory="''${textarget%/*}" "''${textarget%.*}"
grep -qi addbibresource "$textarget" &&
biber --input-directory "''${textarget%/*}" "''${textarget%.*}" &&
$command --output-directory="''${textarget%/*}" "''${textarget%.*}" &&
$command --output-directory="''${textarget%/*}" "''${textarget%.*}"
}

case "$ext" in
        # Try to keep these cases in alphabetical order.
        [0-9]) preconv "$file" | refer -S -e | groff -mandoc -T pdf > "$base".pdf ;;
        c) cc "$file" -o "$base" && "$base" ;;
        cpp) g++ "$file" -o "$base" && "$base" ;;
        cs) mcs "$file" && mono "$base".exe ;;
        go) go run "$file" ;;
        h) sudo make install ;;
        java) javac -d classes "$file" && java -cp classes "''${1%.*}" ;;
        m) octave "$file" ;;
        md)	if  [ -x "$(command -v lowdown)" ]; then
        lowdown --parse-no-intraemph "$file" -Tms | groff -mpdfmark -ms -kept -T pdf > "$base".pdf
        elif [ -x "$(command -v groffdown)" ]; then
        groffdown -i "$file" | groff -T pdf > "$base".pdf
        else
        pandoc -t ms --highlight-style=kate -s -o "$base".pdf "$file"
        fi ; ;;
        mom) preconv "$file" | refer -S -e | groff -mom -kept -T pdf > "$base".pdf ;;
        ms) preconv "$file" | refer -S -e | groff -me -ms -kept -T pdf > "$base".pdf ;;
        org) emacs "$file" --batch -u "$USER" -f org-latex-export-to-pdf ;;
        py) python "$file" ;;
        [rR]md) Rscript -e "rmarkdown::render('$file', quiet=TRUE)" ;;
        rs) cargo build ;;
        sass) sassc -a "$file" "$base".css ;;
        scad) openscad -o "$base".stl "$file" ;;
        sent) setsid -f sent "$file" 2>/dev/null ;;
        tex) textype "$file" ;;
        typ) typst compile "$file" ;;
        *) sed -n '/^#!/s/^#!//p; q' "$file" | xargs -r -I % "$file" ;;
        esac
        '')
# compiler script:1 ends here

# [[file:../../README.org::*Closing][Closing:1]]
];
}
# Closing:1 ends here

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

# [[file:../../README.org::*Closing][Closing:1]]
}
# Closing:1 ends here
