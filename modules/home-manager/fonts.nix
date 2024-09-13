{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    localConf = ''
      <match target="pattern">
        <test qual="any" name="family"><string>NewCenturySchlbk</string></test>
        <edit name="family" mode="assign" binding="same"><string>TeX Gyre Schola</string></edit>
      </match>
    '';
  };
  home.packages = with pkgs; [
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
  ];
}
