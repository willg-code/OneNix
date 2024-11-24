{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    # KEYBINDS #
    "$mainMod" = "SUPER";
    "$shiftMod" = "SHIFT";

    binds.scroll_event_delay = "200"; # scroll delay for keybinds 300->200

    # DOCS: https://wiki.hyprland.org/Configuring/Binds/
    bind = [
      "$mainMod, C, killactive," # exit current window
      "$mainMod, ESC, exit," # exit display manager
      "$mainMod, L, exec, loginctl lock-session" # lock
      "$mainMod, F, fullscreen, 0" # make active window float
      "$mainMod $shiftMod, F, togglefloating," # make active window fullscreen
      "$mainMod, G, pseudo," # float one branch of tree
      "$mainMod, S, togglesplit," # change direction of tree
      "$mainMod $shiftMod, S, swapsplit," # swap two branches of tree
      "$mainMod $shiftMod, P, exec, hyprpicker -ar" # color picker

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod $shiftMod, 1, movetoworkspace, 1"
      "$mainMod $shiftMod, 2, movetoworkspace, 2"
      "$mainMod $shiftMod, 3, movetoworkspace, 3"
      "$mainMod $shiftMod, 4, movetoworkspace, 4"
      "$mainMod $shiftMod, 5, movetoworkspace, 5"
      "$mainMod $shiftMod, 6, movetoworkspace, 6"
      "$mainMod $shiftMod, 7, movetoworkspace, 7"
      "$mainMod $shiftMod, 8, movetoworkspace, 8"
      "$mainMod $shiftMod, 9, movetoworkspace, 9"
      "$mainMod $shiftMod, 0, movetoworkspace, 10"

      # Special workspace (overlays current)
      "$mainMod, X, togglespecialworkspace, magic"
      "$mainMod $shiftMod, X, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e-1"
      "$mainMod, mouse_up, workspace, e+1"

      # Move a window through workspaces with mainmod + shiftMod + scroll
      "$mainMod $shiftMod, mouse_down, movetoworkspace, -1"
      "$mainMod $shiftMod, mouse_up, movetoworkspace, +1"
    ];


    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
