# TODO nixify all the `~/` references
{config, pkgs, file, ... }:
{
  imports = [
	# ./hyprland-keybindings.nix
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
	  "~/.config/hypr/animations.conf"
	  "~/.config/hypr/keybindings.conf"
	  "~/.config/hypr/windowrules.conf"
	  "~/.config/hypr/themes/common.conf # shared theme settings"
	  "~/.config/hypr/themes/colors.conf # wallbash color override"
	  "~/.config/hypr/monitors.conf # initially empty, to be configured by user and remains static"
     ];

      bind = [
        "ALT, Tab, movefocus, d"
        "SUPER, J, togglesplit" # dwindle
        "SUPER ALT, 0, movetoworkspace, 10"
        "SUPER ALT, 1, movetoworkspace, 1"
        "SUPER ALT, 2, movetoworkspace, 2"
        "SUPER ALT, 3, movetoworkspace, 3"
        "SUPER ALT, 4, movetoworkspace, 4"
        "SUPER ALT, 5, movetoworkspace, 5"
        "SUPER ALT, 6, movetoworkspace, 6"
        "SUPER ALT, 7, movetoworkspace, 7"
        "SUPER ALT, 8, movetoworkspace, 8"
        "SUPER ALT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspacesilent, 10"
        "SUPER SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER SHIFT, 9, movetoworkspacesilent, 9"
        "SUPER, 0, workspace, 10"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER SHIFT, left, movetoworkspace, r-1"
        "SUPER SHIFT, right, movetoworkspace, r+1"
        "SUPER SHIFT, down, workspace, empty " # move to next empty workspace
        "SHIFT ALT, down, movewindow, d"
        "SHIFT ALT, up, movewindow, u"
        "SHIFT ALT, left, movewindow, l"
        "SHIFT ALT, right, movewindow, r"
        "SHIFT ALT, J, movewindow, d"
        "SHIFT ALT, K, movewindow, u"
        "SHIFT ALT, H, movewindow, l"
        "SHIFT ALT, L, movewindow, r"
        "SUPER SHIFT, W, exec, $term nmtui"
        "SUPER SHIFT, apostrophe, movetoworkspacesilent, special"
        "SUPER SHIFT, semicolon, workspace, r-1"
        "SUPER, semicolon, workspace, r+1"
        "SUPER, B, exec, pkill .waybar-wrapped || waybar "
        "SUPER, E, exec, mailsync & $term -e neomutt"
        "SUPER, F, fullscreen, 2 "
        "SUPER, P, pseudo"
        "SUPER, space, togglefloating,"
        "SUPER, N, exec, $editor +'VimwikiIndex'"
        "SUPER, backspace, exec, pkill wlogout || wlogout"
        "SUPER, Q, killactive" # exec, $scrPath/dontkillsteam.sh # killactive, kill the window on focus
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
        "SUPER, apostrophe, togglespecialworkspace"
        "SUPER, down, movefocus, d"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER SHIFT, K, exec, keepassxc"
        "SUPER SHIFT, N, exec, emacsclient --create-frame"
        "SUPER, grave, exec, rofimoji --action type copy --selector rofi"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        "ALT SHIFT, N, exec, mpc prev"
        "ALT SHIFT, P, exec, mpc play"
        "ALT, N, exec, mpc next"
        "ALT, P, exec, mpc pause"
        "ALT SHIFT, bracketleft, exec, mpc seek -60"
        "ALT SHIFT, bracketright, exec, mpc seek +60"
        "ALT, bracketleft, exec, mpc seek -10"
        "ALT, bracketright, exec, mpc seek +10"
      ];

      binde = [
        "SUPER SHIFT, down, resizeactive, 0 30"
        "SUPER SHIFT, left, resizeactive, -30 0"
        "SUPER SHIFT, right, resizeactive, 30 0"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
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
	  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH"
	  "dbus-update-activation-environment --systemd --all # for XDPH"
	  "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH"
	 # "/usr/lib/polkit-kde-authentication-agent-1 # authentication dialogue for GUI apps"
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
   $scrPath=~/.config/hypr/scripts

   input {
     kb_layout = us, latam
     kb_variant = alt_intl
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
