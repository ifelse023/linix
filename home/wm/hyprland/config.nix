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
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "0xffcba6f7";
        "col.inactive_border" = "0xff313244";
        resize_on_border = true;
        layout = "dwindle";
        no_border_on_floating = false;

      };

      decoration = {
        rounding = 8;
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

        # enable variable refresh rate (effective depending on hardware)
        vrr = 1;
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
