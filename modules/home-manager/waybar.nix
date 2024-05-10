{ config, lib, pkgs, inputs, ... }:

{
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };

      style = with config.colorScheme.palette; ''
      * {
        color: #${base05};
        border: 0;
        border-radius: 0;
        padding: 0 0;
        font-family:JetBrainsMono Nerd Font;
        margin-right: 5px;
        margin-left: 5px;
        padding-bottom:2px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar {
        background-color: #${base00};
        margin: 0 20px 0 20px;
      }

      #workspaces button {
        padding: 2px 0px;
        border-color: #${base05};
        margin-top:2px;
        border-radius: 25% 10%;
      }

      #workspaces button.active {
        border-bottom: 2px;
        border-style: solid;
        border-radius: 25% 10%;
      }

      #clock, #battery, #cpu, #memory, #idle_inhibitor, #temperature,#custom-keyboard-layout, #backlight, #network, #pulseaudio, #tray, #window,#custom-launcher, #custom-power, #custom-network_traffic, #custom-weather{
        padding: 0 3px;
        border-bottom: 2px;
        border-style: solid;
      }

      #custom-weather{
        margin-top: 5px;
        font-size: 80%;
        border-style: hidden;
      }

      #clock {
        margin-top: 5px;
        font-size: 80%;
        border-style: hidden;
        color:#${base07};
      }

      #battery {
        color: #${base05};
        /* color: #d8dee9; */
      }

      #battery.charging {
        color: #${base0B};
        /* color: #21c181; */
      }


      .warning:not(.charging), .critical:not(.charging), .urgent:not(.charging){
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #cpu {
        /* color:#a3be8c; */
        color: #${base0B}
      }

      #memory {
        color: #${base08};
        /* color: #d3869b; */
      }

      #network.disabled {
        color:#bf616a;
      }

      #network{
        color:#a3be8c;
      }

      #network.disconnected {
        color: #bf616a;
      }

      #pulseaudio {
        color: #b48ead;
      }

      #pulseaudio.muted {
        color: #3b4252;
      }

      #idle_inhibitor {
        color: #ebcb8b;
      }

      #tray {
        color: #${base05};
        /* color: d08770; */
      }

      #custom-launcher {
        color:#99FFFF;
      }

      #custom-launcher,#custom-power{
        border-style: hidden;
        margin-top:2px;
        font-size: 120%;
      }

      #window{
        border-style: hidden;
        margin-top:3px;
        color: #${base05};
      }
      #custom-keyboard-layout{
        color: #${base05};
        /* color: d08770; */
      }
      #custom-network_traffic{
        color: #${base05};
        /* color: d08770; */
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
        modules-right = [ "cpu" "memory" "battery" "tray" 
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
        };

        "custom/weather" = {
          "exec" = "curl 'https://wttr.in/Shenzhen?format=1'";
          "interval" = 900;
          "on-click" = "yad --html --uri='https://wttr.in/Shenzhen' --center --fixed --width=1000 --height=680 --timeout=60 --timeout-indicator=right";
        };

        "custom/weather-wttrbar" = {
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
