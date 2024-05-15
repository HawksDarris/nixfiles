{ config, inputs, pkgs, ... }: 
let 
  theme = "dracula";
  # catppuccin-latte
  # catppuccin-mocha;
  # catppuccin-macchiato;
  # catppuccin-latte;
  # dracula
in {
  colorScheme = inputs.nix-colors.colorSchemes.${theme};
  # can override with pywal

  # TODO Modularize
  # colorScheme = {
  #   slug = "pywalgen";
  #   name = "Pywal Generated";
  #   author = "A computer";
  #   palette = {
  #     base00 = "#100614";
  #     base01 = "#4F4EB4";
  #     base02 = "#DC61A6";
  #     base03 = "#4D9BDD";
  #     base04 = "#F4A3A9";
  #     base05 = "#F0CBB2";
  #     base06 = "#A6A2DE";
  #     base07 = "#edcde4";
  #     base08 = "#a58f9f";
  #     base09 = "#4F4EB4";
  #     base0A = "#DC61A6";
  #     base0B = "#4D9BDD";
  #     base0C = "#F4A3A9";
  #     base0D = "#F0CBB2";
  #     base0E = "#A6A2DE";
  #     base0F = "#59325C";
  #   };
  # };

  gtk = {
    enable = true;
    theme = { 
      dracula = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      catppuccinLatte = {
        name = "Catppuccin-Latte-Compact-Lavender-light";
        package = pkgs.catppuccin-gtk.override {
          accents = ["lavender"];
          size = "compact";
          variant = "latte";
        };
      };
    }.${config.colorScheme.slug};
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = {
        dracula = "Papirus-Dark";
        catppuccinLatte = "Papirus-Light";
      }.${config.colorScheme.slug};
    };
  };

  #   specialisation.light-theme.configuration = {
  #   colorScheme = lib.mkForce { 
  #     slug =  "catppuccinLatte";
  #     colors = {
  #       base00 = "#eff1f5";
  #       base01 = "#e6e9ef";
  #       base02 = "#ccd0da";
  #       base03 = "#bcc0cc";
  #       base04 = "#acb0be";
  #       base05 = "#4c4f69";
  #       base06 = "#dc8a78";
  #       base07 = "#7287fd";
  #       base08 = "#d20f39";
  #       base09 = "#fe640b";
  #       base0A = "#df8e1d";
  #       base0B = "#40a02b";
  #       base0C = "#179299";
  #       base0D = "#1e66f5";
  #       base0E = "#8839ef";
  #       base0F = "#dd7878";
  #     };
  #   };
  # };

  programs.pywal.enable = true;

  home.packages = with pkgs; [
    (hiPrio (writeShellApplication {
      name = "toggle-theme";
      runtimeInputs = with pkgs; [ home-manager coreutils ripgrep ];
        # go back two generations
        # home-manager creates a new generation every time activation script invoked
        text = ''
          "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate
          '';
      }
    )
  )
];
}
