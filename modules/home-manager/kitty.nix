{ config, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
    # theme = "Catppuccin-Macchiato";
    settings = {
      scrollback_lines = 200000;
      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";
    };
    keybindings = {
      "alt+c" = "copy_to_clipboard";
      "alt+v" = "paste_from_clipboard";
    };
  };
}
