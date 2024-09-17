{ defaultBrowser, defaultEditor, term, ... }:

# bind = SUPER, W, exec, $browser # open browser
# bind = SUPER, N, exec, $editor +'VimwikiIndex'
# bindl  = SUPER ALT, M, exec, ${term} -e ncmpcpp
# bind = SUPER, c, exec, $calc
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, R, exec, $file"
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
      "SHIFT ALT, J, movewindow, d"
      "SHIFT ALT, K, movewindow, u"
      "SHIFT ALT, H, movewindow, l"
      "SHIFT ALT, L, movewindow, r"
      "SUPER SHIFT, W, exec, ${term} nmtui"
      "SUPER, return, exec, ${term} "  # TODO pokeget bulbasaur --hide-name open terminal with bulbasaur
      "SUPER SHIFT, apostrophe, movetoworkspacesilent, special"
      "SUPER SHIFT, semicolon, workspace, r-1"
      "SUPER, semicolon, workspace, r+1"
      "SUPER, B, exec, pkill .waybar-wrapped || waybar "
      "SUPER, E, exec, mailsync & ${term} -e neomutt"
      "SUPER, F, fullscreen, 2 "
      "SUPER, P, pseudo"
      "SUPER, space, togglefloating,"
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
      "SUPER, N, exec, $editor +'VimwikiIndex'"
      "SUPER SHIFT, N, exec, emacsclient --create-frame"
      "SUPER, grave, exec, wofi-emoji"
    ];

    binde = [
      "SUPER SHIFT, down, resizeactive, 0 30"
      "SUPER SHIFT, left, resizeactive, -30 0"
      "SUPER SHIFT, right, resizeactive, 30 0"
      "SUPER SHIFT, up, resizeactive, 0 -30"
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
      ", switch:on:Lid Switch, exec, swaylock && systemctl suspend"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      # "SUPER, mouse:273, resizewindow"
      "SUPER SHIFT, mouse:272, resizewindow"
    ];
  };
}
