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
        url = "https://github.com/HawksDarris/Kehua"
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
