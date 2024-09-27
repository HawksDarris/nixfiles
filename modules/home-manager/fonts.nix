{ pkgs, allowed-unfree-packages, ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "TeX Gyre Schola" ];
      sansSerif = [ "FiraCode Nerd Font Mono" ];
    };
  };
  home.packages = with pkgs; [
    corefonts
    commit-mono
    fira-code
    fira-code-symbols
    font-awesome
    gyre-fonts
    inter
    liberation_ttf
    mplus-outline-fonts.githubRelease
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    proggyfonts
    ubuntu_font_family
    vistafonts
  ];
}
