{config, pkgs, ... }: 
{
  services.mako = with config.colorScheme.palette; {
    enable = true;
    backgroundColor = "#${base01}";
    borderColor = "#${base0E}";
    textColor = "#${base04}";
    width = 300; 
    height = 300;
    borderRadius = 5;
    borderSize = 2;
    maxVisible = 20;
    format = "󰟪 %a\\n<b>󰋑 %s</b>\\n%b";
    icons = true;
    font = "JetBrainsMono Nerd Font 8";
    layer = "overlay";
    defaultTimeout = 5000;
  };
}
