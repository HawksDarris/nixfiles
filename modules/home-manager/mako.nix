{config, ... }: 
{
  services.mako = with config.colorScheme.palette; {
    enable = true;
    font = "JetBrainsMono Nerd Font 8";
    backgroundColor = "#${base00}";
    borderColor = "#${base00}";
    textColor = "#${base05}";
    defaultTimeout = 5000;
    width = 300; 
    height = 300;
    borderRadius = 5;
    borderSize = 2;
    maxVisible = 20;
    format = "󰟪 %a\\n<b>󰋑 %s</b>\\n%b";
    icons = true;
    iconPath = "./assets/notifier-icons:./assets/notifier-icons/vol"; #colon-delimited string of paths
    layer = "overlay";
    extraConfig = ''
      ignore-timeout=1
      [urgency=low]
      border-color=#${base00}
      [urgency=normal]
      border-color=#${base0A}
      [urgency=high]
      border-color=#${base08}
      '';
  };
}  
