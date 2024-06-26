{ inputs, config, ...}:
let 
  hvr = "5";
  active_rad = "8";
  mgn = "5" ;
  button_rad = "5";
  icon_path = ./assets/wlogout/icons;

in {
  # wlogout
  programs.wlogout = {
    enable = true;
    style = with config.colorScheme.palette; ''
    * {
      font-weight: bold;
    }

    window {
      background-color: rgba(0, 0, 0, 0.7);
    }

    button {
      color: #${base05};
      background-color: #${base00};
      outline-style: none;
      border: none;
      border-width: 0px;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 20%;
      border-radius: ${button_rad}px;
      box-shadow: none;
      text-shadow: none;
      animation: gradient_f 20s ease-in infinite;
    }

    button:focus {
      background-color: #${base0E};
      background-size: 30%;
      text-shadow: 2px 2px #${base00};
    }

    button:hover {
      background-color: #${base0E};
      background-size: 40%;
      border-radius: ${active_rad}px;
      animation: gradient_f 20s ease-in infinite;
      transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      text-shadow: 2px 2px #${base00};
    }

    button:hover#lock {
      margin : ${hvr}px 0px ${hvr}px ${mgn}px;
    }

    button:hover#logout {
      margin : ${hvr}px 0px ${hvr}px 0px;
    }

    button:hover#suspend {
      margin : ${hvr}px ${hvr}px ${hvr}px 0px;
    }

    button:hover#shutdown {
      margin : ${hvr}px ${hvr}px ${hvr}px 0px;
    }

    button:hover#hibernate {
      margin : ${hvr}px ${hvr}px ${hvr}px 0px;
    }

    button:hover#reboot {
      margin : ${hvr}px ${mgn}px ${hvr}px 0px;
    }

#lock {
  background-image: image(url("${icon_path}/lock_white.png"), url("/usr/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
  border-radius: ${button_rad}px 0px 0px ${button_rad}px;
  margin : ${mgn}px 0px ${mgn}px ${mgn}px;
}

#logout {
  background-image: image(url("${icon_path}/logout_white.png"), url("/usr/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
  border-radius: 0px 0px ${button_rad}px ${button_rad}px;
  margin : ${mgn}px 0px ${mgn}px 0px;
}

#suspend {
  background-image: image(url("${icon_path}/suspend_white.png"), url("/usr/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
  border-radius: ${button_rad}px ${button_rad}px 0px 0px;
  margin : ${mgn}px ${mgn}px ${mgn}px 0px;
}

#shutdown {
  background-image: image(url("${icon_path}/shutdown_white.png"), url("/usr/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
  border-radius: 0px 0px ${button_rad}px 0px;
  margin : ${mgn}px ${mgn}px ${mgn}px 0px;
}

#hibernate {
  background-image: image(url("${icon_path}/hibernate_white.png"), url("/usr/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
  border-radius: ${button_rad}px 0px 0px 0px;
  margin : ${mgn}px 0px ${mgn}px 0px;
}

#reboot {
  background-image: image(url("${icon_path}/reboot_white.png"), url("/usr/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
  border-radius: 0px ${button_rad}px 0px 0px;
  margin : ${mgn}px ${mgn}px ${mgn}px 0px;
}

'';
    # ../../modules/home-manager/assets/wlogout/wlogout.css;

    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }

      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
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
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }

      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }

    ];
  };
}

