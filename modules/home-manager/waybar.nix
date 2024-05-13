{ config, lib, pkgs, inputs, username, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };

    style = with config.colorScheme.palette; ''
    @import url("/home/${username}/.cache/wal/colors-waybar.css");

    @define-color bg @background;
    @define-color fg @foreground;
    @define-color textcolor @cursor;

    @import url("/home/${username}/.config/waybar/other.css");

    #custom-launcher {
      padding: 0 6px 0 10px;
      color:#99FFFF;
    }
    '';
      # ./assets/waybar.css;

      settings = [{
        "layer" = "top";
        "position" = "bottom";
        "height" = 20;
        "margin" = "0 0 0 0";
        "spacing" = 0;

        modules-left = [ "custom/launcher" "hyprland/workspaces" "hyprland/window" 
          # "mpd"
        ];
        modules-center = [
          "clock"
          # "custom/weather-wttrbar"
          "custom/weather"
        ];
        modules-right = [ "network" "cpu" "memory" "battery" "tray" 
          # "network"  # TODO add this again with an on-click to launch nmtui
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
          "on-click" = "kitty -e nmtui";
        };

        "custom/weather" = {
          "format" = "{}°";
          "tooltip" = true;
          "interval" = 3600;
          "exec" = "wttrbar";
          "return-type" = "json";
          "on-click" = "wttrbar --date-format '%m/%d' --location Shenzhen --hide-conditions";
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
