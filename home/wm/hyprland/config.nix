{
  wayland.windowManager.hyprland = {
    catppuccin = {
      enable = true;
      accent = "pink";
      flavor = "mocha";
    };
    settings = {
      monitor = [
        "eDP-1, 1920x1080, 0x0, 1"
        "HDMI-A-1, 1920x1080, 1920x0, 1"
      ];

      "$mod" = "SUPER";

      general = {
        gaps_in = 3;
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        resize_on_border = true;
        "layout" = "dwindle";
        no_border_on_floating = false;

        sensitivity = 0.9;
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };

        drop_shadow = true;

        shadow_ignore_window = true;
        shadow_offset = "0 2";
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000055)";
      };

      animations = {
        enabled = false;
        animation = [
          "border, 1, 2, default"
          "fade, 1, 4, default"
          "windows, 1, 3, default, popin 80%"
          "workspaces, 1, 2, default, slide"
        ];
      };

      input = {
        kb_layout = "de";
        kb_variant = "us";
        kb_options = "ctrl:nocaps";

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

      debug.disable_logs = true;
    };
  };
}
