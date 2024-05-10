{ inputs, ...}:
{
  # wlogout
  programs.wlogout = {
    enable = true;
    style = ''

      * {
        background-image: none;
        font-size: 100%;
        color: white;
      }

      window {
        background-color: #99FFFF;
        /* background-color: $${WindBg}; */
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

