{config, pkgs, file, inputs, username, ... }:
{
  imports = [
	./hyprland-keybindings.nix
  ];
  home.packages = with pkgs; [
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
        xwayland.enable = true;

    systemd.enable = true;

    settings = {
      source = [
        "/home/${username}/.config/hypr/animations.conf"
        "/home/${username}/.config/hypr/keybindings.conf"
        "/home/${username}/.config/hypr/windowrules.conf"
        "/home/${username}/.config/hypr/themes/common.conf" # shared theme settings
        "/home/${username}/.config/hypr/themes/colors.conf" # wallbash color override
        "/home/${username}/.config/hypr/monitors.conf" # initially empty, to be configured by user and remains static
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1.8"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      exec-once = [
	      # "lxqt-policykit-agent"
	      # "/usr/lib/polkit-kde-authentication-agent-1 # authentication dialogue for GUI apps"

# "virsh net-autostart default"

	      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH"
	      "dbus-update-activation-environment --systemd --all # for XDPH"
	      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH"
	      "waybar # launch the system panel"
	      "blueman-applet # systray app for BT"
	      "nm-applet --indicator # systray app for Network/Wifi"
        "mako"
	      "wl-paste --type text --watch cliphist store # clipboard store text data"
	      "wl-paste --type image --watch cliphist store # clipboard store image data"
	      "$scrPath/swwwallpaper.sh # start wallpaper daemon"
	      "$scrPath/batterynotify.sh # battery notification"
      ];
    };
    extraConfig = with config.colorScheme.palette; ''
   general:col.inactive_border = rgb(${base08}) rgb(${base09}) 45deg
   general:col.active_border = rgb(${base0A}) rgb(${base0F}) 45deg
   $scrPath=/home/${username}/.config/hypr/scripts

   input {
     kb_layout = us
     kb_variant = altgr-intl
     kb_options = caps:escape
     follow_mouse = 1
     touchpad {
       natural_scroll = no
     }

     sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
     force_no_accel = 1
   }

    gestures {
	    workspace_swipe = true
		    workspace_swipe_fingers = 3
    }

    dwindle {
	    pseudotile = yes
		    preserve_split = yes
    }

    misc {
	    vrr = 0
    }
    '';

  };

  #home.file."${config.xdg.configHome}".text = ''
  # home.file.".config/swappy/config".text = ''
  #   [Default]
  # save_dir=${home.homeDirectory}/Pictures/Screenshots
  # save_filename_format=%Y%m%d-%H%M%S.png
  # '';
  # source = ./unported/hyprpaper.conf;
  # recursive = true;
}
