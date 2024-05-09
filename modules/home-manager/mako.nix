{config, pkgs, ... }: 
{
  services.mako = with config.colorScheme.colors; {
    enable = true;
    backgroundColor = "#${base01}";
    borderColor = "#${base0E}";
    textColor = "#${base04}";
    borderRadius = 5;
    borderSize = 2;
    layer = "overlay";
  };
}
