{ inputs, ...}:
{
  # wlogout
  programs.wlogout = {
    enable = true;
    style = ''

      * {
        background-image: none;
        font-size: 100%;
      }

      window {
    /*    background-color: $${WindBg}; */
        background-color: black;
      }

    '';
    # ../../modules/home-manager/assets/wlogout/wlogout.css;

    layout = [
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }

      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout";
        keybind = "e";
      }

      {
        label = "suspend";
        action = "swaylock -f && systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }

      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }

      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }

      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
  };
}

