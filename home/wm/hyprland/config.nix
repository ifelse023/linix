{ theme, ... }:

{
  wayland.windowManager.hyprland = with theme.colors; {
    settings = {
      monitor = [
        "eDP-1, 1920x1080, 0x0, 1"
        "HDMI-A-1, 1920x1080, 1920x0, 1"
      ];

      "$mod" = "SUPER";

      exec-once = [ "hyprctl setcursor Bibata-modern-Classic 24" ];
      env = [ "HYPRCURSOR_SIZE,24" ];

      cursor = {
        no_warps = true;
      };

      general = {
        gaps_in = 4;
        gaps_out = 6;
        border_size = 1;
        "col.active_border" = " rgb(${mauve}) rgb(${lavender})";
        "col.inactive_border" = "rgb(${surface0})";
        resize_on_border = true;
        "layout" = "dwindle";
        no_border_on_floating = false;

        sensitivity = 0.6;
      };

      decoration = {
        rounding = 7;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = true;
          new_optimizations = 1;
          xray = true;
          contrast = 0.7;
          brightness = 0.8;
          vibrancy = 0.2;
        };

        drop_shadow = false;
        shadow_range = 20;
        shadow_render_power = 5;
        "col.shadow" = "rgba(292c3cee)";
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
        pseudotile = false;
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
      };

      # touchpad gestures
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      xwayland.force_zero_scaling = true;

      debug.disable_logs = false;
    };
  };
}
