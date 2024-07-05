{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1, 1920x1080, 0x0, 1"
        "HDMI-A-1, 1920x1080, 1920x0, 1"
      ];

      "$mod" = "SUPER";

      cursor = {
        no_warps = true;
      };

      general = {
        gaps_in = 3;
        gaps_out = 3;
        border_size = 1;
        "col.active_border" = " rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        "layout" = "dwindle";
        no_border_on_floating = false;

        sensitivity = 0.6;
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = false;
          brightness = 1.0;
          contrast = 1.0;
          noise = 1.0e-2;

          vibrancy = 0.2;
          vibrancy_darkness = 0.5;

          passes = 4;
          size = 7;

          popups = true;
          popups_ignorealpha = 0.2;
        };

        drop_shadow = false;
        shadow_ignore_window = true;
        shadow_range = 10;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000055)";
      };

      animations = {
        enabled = true;
        animation = [
          "border, 1, 2, default"
          "fade, 1, 4, default"
          "windows, 1, 3, default, popin 80%"
          "workspaces, 1, 2, default, slide"
        ];
      };
      group = {
        groupbar = {
          font_size = 16;
          gradients = false;
        };

        "col.border_active" = "rgba(88888888)";
        "col.border_inactive" = "rgba(00000088)";

        #"col.border_active" = "rgba (ca9ee6ff) rgba (f2d5cfff) 45 deg";
        #"col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      };

      input = {
        kb_layout = "de";
        kb_variant = "us";

        # focus change on cursor move
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
      };

      dwindle = {
        # keep floating dimentions while tiling
        no_gaps_when_only = 1;
        pseudotile = true;
        preserve_split = true;
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

        # enable variable refresh rate (effective depending on hardware)
        vrr = 1;

        mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true; # enable dpms on keyboard action

        no_direct_scanout = false;
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
