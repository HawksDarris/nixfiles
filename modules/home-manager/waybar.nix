{ config, lib, pkgs, ... }:

{
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };

      style = ./assets/waybar.css;

      settings = [{
        "layer" = "top";
        "position" = "bottom";
        "height" = 40;
        "margin" = "0 0 0 0";
        "spacing" = 0;

        modules-left = [ "custom/launcher" "hyprland/workspaces" "hyprland/window" 
          # "mpd"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [ "cpu" "memory" "battery" "tray" "custom/weather"
          # "network"  # Maybe I will add this again with an on-click to launch nmtui
          # "backlight"
          # "pulseaudio" 
          # "custom/powermenu"
        ];

        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "all-outputs" = true;
          "sort-by-number" = true;
          "format-icons" = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "focused" = "";
            "default" = "";
          };
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };

        "hyprland/window" = {
          "format" = "{}";
          "icon" = true;
          "icon-size" = 20;
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };

        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill -x rofi || ~/.config/hypr/scripts/rofilaunch.sh";
          "on-click-middle" = "exec default_wall";
          "on-click-right" = "exec wallpaper_random";
          "tooltip" = false;
        };

        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [ "" "" "" ];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };

        "battery" = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity: >3}%";
          "format-icons" = ["" "" "" "" ""];
        };

        "memory" = {
          "interval" = 1;
          "format" = "󰻠 {percentage}%";
          "states" = {
            "warning" = 85;
          };
          "on-click" = "kitty -e btm";
        };

        "cpu" = {
          "interval" = 1;
          "format" = "󰍛 {usage}%";
          "on-click" = "kitty -e btm";
        };

        # TODO remove or use mpd

        "network" = {
          "format-disconnected" = "󰯡 Disconnected";
          "format-ethernet" = "󰒢 Connected!";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-wifi" = "󰖩 {essid}";
          "interval" = 1;
          "tooltip" = false;
        };

        "custom/weather" = {
          "exec" = "curl 'https://wttr.in/Shenzhen?format=2'";
          "interval" = 900;
          "on-click" = "yad --html --uri='https://wttr.in/Schenzhen' --center --fixed --width=1000 --height=680 --timeout=60 --timeout-indicator=right";
        };

        "clock" = {
          "tooltip-format" = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          "format" = " {:%a %d %b  %I:%M %p}";
          "format-alt" = " {:%d/%m/%Y  %H:%M:%S}";
          "timezones" = [ "Asia/Shanghai" ];
          "interval" = 1;
          "on-click" = "~/.config/waybar/scripts/OCV";
        };

        "bluetooth" = {
          "format-alt" = "bluetooth: {status}";
          "format-on" = "";
          "format-off" = "!";
          "on-click" = "kitty -e bluetoothctl";
          "tooltip-format" = "{status}";
        };

        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu/type-3/powermenu.sh";
          "tooltip" = false;
        };

        "tray" = {
          "icon-size" = 20;
          "spacing" = 5;
        };

      }];

    };
  }
