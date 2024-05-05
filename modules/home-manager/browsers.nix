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
       #"*".installation_mode = "blocked"; # blocks all addons except the ones specified below
       "uBlock0@raymondhill.net" = {
         install_url = "./assets/ublock_origin-1.57.2.xpi";
         installation_mode = "force_installed";
       };
       # Privacy Badger:
       "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
     };

     Preferences = { 
       "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
       "extensions.pocket.enabled" = false;
       "extensions.screenshots.disabled" = true;
       "browser.topsites.contile.enabled" = false;
       "browser.formfill.enable" = false;
       "browser.search.suggest.enabled" = false;
       "browser.search.suggest.enabled.private" = false;
       "browser.urlbar.suggest.searches" = false;
       "browser.urlbar.showSearchSuggestionsFirst" = false;
       "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
       "browser.newtabpage.activity-stream.feeds.snippets" = false;
       "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
       "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
       "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
       "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
       "browser.newtabpage.activity-stream.showSponsored" = false;
       "browser.newtabpage.activity-stream.system.showSponsored" = false;
       "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
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
