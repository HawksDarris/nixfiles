{ config, pkgs, lib, inputs, username, ... }:

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

# lxqt-policykit-agent
bat
brightnessctl
brightnessctl
bun
dart-sass
dbus
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
  EDITOR = "nvim";
};

programs.home-manager.enable = true;

}
