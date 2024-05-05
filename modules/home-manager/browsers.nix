{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [ 
    chromium
    qutebrowser
];
programs.firefox = {
  enable = true;
  policies = {
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    EnableTrackingProtection = {
      Value= true;
         Locked = true;
         Cryptomining = true;
         Fingerprinting = true;
       };
     DisablePocket = true;
     DisableFirefoxAccounts = true;
     DisableAccounts = true;
     DisableFirefoxScreenshots = true;
     OverrideFirstRunPage = "";
     OverridePostUpdatePage = "";
     DontCheckDefaultBrowser = true;
     DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
     DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
     SearchBar = "unified"; # alternative: "separate"
     ExtensionSettings = {
       "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
       "uBlock0@raymondhill.net" = {
         install_url = "./assets/ublock_origin-1.57.2.xpi";
         installation_mode = "force_installed";
       };
     };
  };

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
      # allow local, unsigned extensions
      # "xpinstall.signatures.required" = false
      # remember 
      # "signon.rememberSignons" = false;
    };
    
    extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
      # Error 451 = legal ban on download.
      # ublock-origin
      darkreader
    ];
  };
};
  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
}
