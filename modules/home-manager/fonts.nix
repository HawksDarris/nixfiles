{ pkgs, ... }:
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
    fira-code
    fira-code-symbols
    font-awesome
    liberation_ttf
    mplus-outline-fonts.githubRelease
    nerdfonts
    noto-fonts
    noto-fonts-emoji
    proggyfonts
    ubuntu_font_family
    liberation_ttf
    gyre-fonts
    noto-fonts-cjk
  ];
}
