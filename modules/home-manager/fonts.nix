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
    gyre-fonts
    liberation_ttf
    liberation_ttf
    mplus-outline-fonts.githubRelease
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    proggyfonts
    ubuntu_font_family
  ];
}
