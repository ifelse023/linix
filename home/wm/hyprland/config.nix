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
        gaps_in = 2;
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "0xffcba6f7";
        "col.inactive_border" = "0xff313244";
        resize_on_border = true;
        layout = "dwindle";
        no_border_on_floating = false;

        sensitivity = 0.9;
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          new_optimizations = true;
        };

        drop_shadow = true;

        shadow_ignore_window = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "0x66000000";
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
