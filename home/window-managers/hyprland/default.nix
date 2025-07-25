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
        rounding = 10;
        rounding_power = 3;
        blur = {
          enabled = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.01;

          vibrancy = 0.2;
          vibrancy_darkness = 0.5;

          passes = 4;
          size = 7;

          popups = true;
          popups_ignorealpha = 0.2;
        };
        shadow = {
          enabled = true;
          color = "rgba(00000055)";
          ignore_window = true;
          offset = "0 15";
          range = 100;
          render_power = 2;
          scale = 0.97;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
          "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
          "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "emphasizedAccel, 0.3, 0, 0.8, 0.15"
          "standardDecel, 0, 0, 0, 1"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.52, 0.03, 0.72, 0.08"
        ];
        animation = [
          "windowsIn, 1, 3, emphasizedDecel, popin 80%"
          "windowsOut, 1, 2, emphasizedDecel, popin 90%"
          "windowsMove, 1, 3, emphasizedDecel, slide"
          "border, 1, 10, emphasizedDecel"
          "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
          "layersOut, 1, 2.4, menu_accel, popin 94%"
          "fadeLayersIn, 1, 0.5, menu_decel"
          "fadeLayersOut, 1, 2.7, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
          "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
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

        "$mod, Print, exec, ${lib.getExe pkgs.flameshot} gui"
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
