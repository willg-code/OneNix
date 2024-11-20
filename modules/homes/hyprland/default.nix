{ config, lib, pkgs, ... }:

let
  moduleName = "hyprland";
  cfg = config.modules.homes.${moduleName};
  colors = config.modules.homes.colors;
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  imports = [
    ./hypridle.nix
    ./hyprlock.nix
  ];

  config = lib.mkIf cfg.enable {
    # Required dependencies for this module
    home.packages = [
      pkgs.hyprpicker # color picker for hyprland
      pkgs.wl-clipboard-rs # wl-clipboard implementation, required for hyprpicker -a
      pkgs.hyprpolkitagent # polkit agent
    ];

    home.sessionVariables.NIXOS_OZONE_WL = "1"; # make electron apps use wayland

    # Hyprland config
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "hypridle" # start idle daemon
          "systemctl --user start hyprpolkitagent" # start polkit daemon
        ];
        monitor = ",preferred,auto,auto"; # monitor config that generally works
        general = {
          gaps_in = "5"; # size (in pixels) of gap between the windows
          gaps_out = "5"; # size (in pixels) of gap on the edge of the screen
          border_size = "2"; # size (in pixels) of winsow border
          "col.active_border" = "rgba(${colors.primaryHighlight}FF)";
          "col.inactive_border" = "rgba(${colors.neutralDark}A5)";
          snap = {
            enabled = true;
            border_overlap = true;
          };
          decoration = {
            rounding = "8"; # rounded corner size
            inactive_opacity = "0.9"; # inactive window opacity
            dim_inactive = "true"; # darken the inactive windows
            dim_strength = "0.1"; # how much to darken inactives
            blur = {
              xray = "false"; # floating windows ignore what's underneath
              size = "12"; # how large the blur is
            };
          };

          dwindle = {
            pseudotile = "true"; # enable mid-tree window floating (pseudo)
            preserve_split = "true";
          };

          misc = {
            disable_hyprland_logo = "true"; # disable default hyprland backgrounds
            disable_splash_rendering = "true"; # disable splash text
            disable_autoreload = "true"; # disable script reload, not needed bc nixos
            focus_on_activate = "true"; # apps can request focus
          };

          # KEYBINDS #
          "$mainMod" = "SUPER";
          "$shiftMod" = "SHIFT";

          # DOCS: https://wiki.hyprland.org/Configuring/Binds/
          bind = [
            "$mainMod, C, killactive," # exit current window
            "$mainMod, ESC, exit," # exit display manager
            "$mainMod, L, exec, loginctl lock-session" # lock
            "$mainMod, F, fullscreen, 0" # make active window float
            "$mainMod $shiftMod, F, togglefloating," # make active window fullscreen
            "$mainMod, G, pseudo," # float one branch of tree
            "$mainMod, S, togglesplit," # change direction of tree
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

          # These make the behavior of apps more predictable
          windowrulev2 = [
            "suppressevent maximize, class:.*" # no auto maximization
            "suppressevent fullscreen, class:.*" # no auto fullscreen
          ];
        };
      };
    };
  }
