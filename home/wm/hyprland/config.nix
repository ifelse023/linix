{
  wayland.windowManager.hyprland = {

    settings = {
      exec-once = [
        "uwsm finalize"
        "clipse -listen"
      ];
      monitor = [
        "eDP-1, 1920x1080, 0x0, 1"
        "HDMI-A-1, 1920x1080, 1920x0, 1"
      ];
      "$mod" = "SUPER";

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(07b5efff) rgba(bb9af7ff) 45deg";
        "col.inactive_border" = "rgba(565f89cc) rgba(9aa5cecc) 45deg";
        resize_on_border = true;
        layout = "dwindle";
        no_border_on_floating = false;

      };

      decoration = {
        rounding = 8;
        rounding_power = 3;
        blur = {
          enabled = true;
          passes = 4;
          size = 7;
          new_optimizations = true;
          ignore_opacity = false;
          xray = false;

        };
        shadow = {
          enabled = true;
          color = "0x66000000";
          ignore_window = true;
          offset = "2 2";
          range = 8;
          render_power = 2;
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
        # disable auto polling for config file changes
        disable_autoreload = true;
        disable_splash_rendering = true;
        enable_swallow = true; # hide windows that spawn other windows

        disable_hyprland_logo = true;
        force_default_wallpaper = 0;

        # disable dragging animation
        animate_mouse_windowdragging = false;

        mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true; # enable dpms on keyboard action

      };

      # touchpad gestures
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      debug.disable_logs = false;
    };
  };
}
