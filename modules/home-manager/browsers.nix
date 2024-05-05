{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [ 
    chromium
    qutebrowser
];
programs.firefox = {
  enable = true;
  profiles.sour = {
    bookmarks = [
      {
        name = "kehua";
        tags = [ "TEFL" "repo" "github" "git" ];
        keyword = "kehua";
        url = "https://github.com/HawksDarris/Kehua";
      }
      {
        name = "toPhonetics";
        tags = [ "TEFL" ];
        keyword = "phonetics";
        url = "https://tophonetics.com/";
      }
      {
        name = "Grade 7 Lesson Plans";
        tags = [ "TEFL" ];
        keyword = "G7";
        url = "file:///home/sour/share/Teaching/TEFL/Lesson%20Plans/Grade%207%20Lesson%20Plans.html";
      }
      {
        name = "Grade 6 Lesson Plans";
        tags = [ "TEFL" ];
        keyword = "G6";
        url = "file:///home/sour/share/Teaching/TEFL/Lesson%20Plans/Grade%206%20Lesson%20Plans.html";
      }
      {
        name = "Home-Manager Options";
        tags = [ "nix" "options" ];
        keyword = "ho";
        url = "https://home-manager-options.extranix.com/";
      }
    ];

    settings = {
      "dom.security.https_only_mode" = true;
      "browser.download.panel.shown" = true;
      "identity.fx.accounts.enabled" = false;
      # "signon.rememberSignons" = false;
    };
    
    extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
      ublock-origin
      darkreader
    ];
  };
};
}
