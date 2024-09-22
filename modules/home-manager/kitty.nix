{ config, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 12;
    };
    # theme = "Catppuccin-Mocha";
    settings = {
      scrollback_lines = 200000;
      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";
    };
    keybindings = {
      "alt+c" = "copy_to_clipboard";
      "alt+v" = "paste_from_clipboard";
    };
    extraConfig = ''
    '';
  };
}
