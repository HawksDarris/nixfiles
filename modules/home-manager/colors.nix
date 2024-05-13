{ inputs, ... }: 
let 
  theme = "catppuccin-macchiato";
  # catppuccin-latte
  # catppuccin-mocha;
  # catppuccin-macchiato;
  # catppuccin-latte;
  # dracula
in {
  # colorScheme = inputs.nix-colors.colorSchemes.${theme};

  # TODO Modularize
  colorScheme = {
    slug = "pywalgen";
    name = "Pywal Generated";
    author = "A computer";
    palette = {
      base00 = "#100614";
      base01 = "#4F4EB4";
      base02 = "#DC61A6";
      base03 = "#4D9BDD";
      base04 = "#F4A3A9";
      base05 = "#F0CBB2";
      base06 = "#A6A2DE";
      base07 = "#edcde4";
      base08 = "#a58f9f";
      base09 = "#4F4EB4";
      base0A = "#DC61A6";
      base0B = "#4D9BDD";
      base0C = "#F4A3A9";
      base0D = "#F0CBB2";
      base0E = "#A6A2DE";
      base0F = "#59325C";
    };
  };
}
