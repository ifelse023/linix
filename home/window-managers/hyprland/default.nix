{
  lib,
  pkgs,
  lib',
  multiMonitorSetup ? true,
  ...
}:
let
  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );
in
{

  imports = [ ./hyprpaper.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "uwsm finalize"
      ];

      monitor =
        if multiMonitorSetup then
          [
            "eDP-1,disable"
            "DP-1,2560x1440@74.92,0x0,1"
            "HDMI-A-1,1920x1080@60.00,2560x250,1"
          ]
        else
          [ ];

      workspace =
        if multiMonitorSetup then
          [
            "1, monitor:DP-1, default:true"
            "2, monitor:DP-1, default:true"
            "3, monitor:DP-1, default:true"
            "4, monitor:HDMI-A-1, default:true"
            "5, monitor:HDMI-A-1, default:true"
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
          ]
        else
          [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
          ];

      "$mod" = "SUPER";

      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 2;
        resize_on_border = true;
        layout = "dwindle";
        no_border_on_floating = false;

      };

      decoration = {
        rounding = 8;
        rounding_power = 3;
        blur = {
          enabled = true;
          passes = 3;
          size = 6;
          new_optimizations = true;

        };
        shadow = {
          enabled = true;
          range = 15;
          render_power = 3;
          ignore_window = true;
          offset = "2, 4";
          # color = "rgba(2e2e2e2e)";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1.0"
          "md2, 0.4, 0, 0.2, 1"
        ];

        # Define animations
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      input = {
        follow_mouse = 1;
        kb_layout = "de";
        kb_variant = "us";
        kb_options = "caps:escape";
        sensitivity = 0.5;

        touchpad.natural_scroll = "no";
      };

      dwindle = {
        # keep floating dimentions while tiling
        pseudotile = true;
        preserve_split = true;
      };

      render = {
      };

      misc = {
        disable_autoreload = true;
        disable_splash_rendering = true;
        enable_swallow = true; # hide windows that spawn other windows

        disable_hyprland_logo = true;
        force_default_wallpaper = 0;

        # disable dragging animation
        animate_mouse_windowdragging = false;

        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;

      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      debug.disable_logs = false;

      layerrule = [
        "blur, dunst"
        "blur, fuzzel"
        "noanim, fuzzel"
      ];
      # windowrule = [
      #   "float,title:^(Open File)(.*)$"
      #   "float,title:^(Select a File)(.*)$"
      #   "float,title:^(Open Folder)(.*)$"
      #   "float,float,title:^(Save As)(.*)$"
      #   "float,title:^(Save As)(.*)$"
      #   "float,title:^(File Upload)(.*)$"
      #   "float, title:^(.*Bitwarden.*)$"
      # ];
      #
      # window rules
      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
        "idleinhibit focus,class:com.mitchellh.ghostty"
        "idleinhibit focus,class:com.mitchellh.kitty"
        "idleinhibit focus,class:com.mitchellh.foot"
        "idleinhibit fullscreen, class:^(firefox-nightly)$"

        "float, class:^(com.saivert.pwvucontrol)$"
        "float,title:^(Volume Control)$"

        "workspace special silent, title:^(Firefox — Sharing Indicator)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window).)$"

        "workspace 4 , class:^(firefox-nightly)$"
        "workspace 5, title:^(.*(Disc|WebC)ord.*)$"
        "workspace 1 , class:^(neovide)$"

        "float, title:^(File Upload)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Select a File)(.*)$"

        "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "pin, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod SHIFT, E, exec, pkill Hyprland"
        "SUPER, C, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        "$mod, Q, killactive,"
        "$mod, C, cyclenext,"
        "$mod, F, fullscreen,"
        "$mod, Space, fullscreen,"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"

        ", Print, exec, ${lib.getExe pkgs.hyprshot} -m region --clipboard-only"

        ("$mod, Return, exec, uwsm app -- " + lib'.terminal)

        "$mod, D, exec, fuzzel launch-prefix='uwsm app -- '"
        "$mod, Escape, exec, wlogout -p layer-shell"
        "$mod, L, exec, loginctl lock-session"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"

        "$mod, M, exit"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"

        "SUPER_SHIFT, left,  movewindow, l"
        "SUPER_SHIFT, right, movewindow, r"
        "SUPER_SHIFT, up,    movewindow, u"
        "SUPER_SHIFT, down,  movewindow, d"

        "SUPER, mouse:276, fullscreen, 0 "
        "SUPER, mouse:276, exec, $notifycmd 'Fullscreen Mode'"
      ]
      ++ workspaces;

      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
    };
  };
}
