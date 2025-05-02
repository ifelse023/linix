{ lib, pkgs, ... }:
let
  mod = "Mod4";
in
{

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway_git;
    systemd.enable = false;
    checkConfig = false;
    wrapperFeatures.gtk = true;
    config = {
      output = {
        "*" = {
          scale = "1";
          adaptive_sync = "off";
          max_render_time = "5";
        };
        "HDMI-A-1" = {
          mode = "1920x1080@60Hz";
          position = "2560,0";
          scale = "1";
        };
        "DP-1" = {
          mode = "2560x1440@59.95Hz";
          position = "0,0";
          scale = "1";
        };
      };
      assigns = {
        "number 4" = [ { app_id = "firefox-nightly"; } ];
        "number 6" = [ { app_id = "discord"; } ];
        "number 1" = [ { app_id = "neovide"; } ];
      };

      floating.criteria = [
        {
          app_id = "firefox-nightly";
          title = "^moz-extension:";
        }
        {
          app_id = "firefox-nightly";
          title = "^Password Required";
        }
        { app_id = "pwvucontrol"; }
        { app_id = "flameshot"; }
        { app_id = "menu"; }
        { app_id = "dialog"; }
        { app_id = "Preferences"; }
        { app_id = "task_dialog"; }
        { app_id = "bubble"; }
        { app_id = "pop-up"; }
        { app_id = "webconsole"; }

      ];

      input = {
        "type:keyboard" = {
          xkb_layout = "de";
          xkb_variant = "us";
          xkb_options = "caps:escape";
        };

        # "type:touchpad" = {
        #   tap = "enabled";
        # };

      };
      bars = [ ];
      defaultWorkspace = "workspace number 1";
      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
      };
      gaps = {
        inner = 2;
        smartGaps = true;
        smartBorders = "on";
      };
      startup = [
        { command = "uwsm finalize"; }
        {

          command =
            let
              wallpaper = pkgs.fetchurl {
                url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-mocha.png";
                sha256 = "7e6285630da06006058cebf896bf089173ed65f135fbcf32290e2f8c471ac75b";
              };
              setWallpaper = pkgs.writeShellScript "set-wallpaper" ''
               ${lib.getExe pkgs.killall} swaybg
                uwsm app -- ${lib.getExe pkgs.swaybg} -m fill -i ${wallpaper}
              '';
            in
            "${setWallpaper}";
          always = true;
        }
        { command = "uwsm app -- firefox-nightly"; }
      ];
      keybindings =
        {
          XF86MonBrightnessUp = "exec uwsm app -- ${lib.getExe pkgs.brightnessctl} set 10%-";
          XF86MonBrightnessDown = "exec uwsm app -- ${lib.getExe pkgs.brightnessctl} set +10%";
        }
        // {
          "${mod}+Return" = "exec uwsm app -- ghostty";
          "${mod}+d" = "fuzzel";
          Print = "${lib.getExe pkgs.flameshot} gui";

        }

        // {

          "${mod}+Shift+m" = "exec uwsm stop";
          "${mod}+Shift+r" = "reload";

          "${mod}+q" = "kill";

          "${mod}+z" = "layout toggle splith tabbed";

          "${mod}+space" = "exec ${pkgs.i3-cycle-focus}/bin/i3-cycle-focus cycle";

          "${mod}+b" = "workspace back_and_forth";

          "${mod}+Shift+p" = "move workspace to output right";
          "${mod}+Tab" = "exec ${pkgs.i3-cycle-focus}/bin/i3-cycle-focus cycle";
          "${mod}+e" = "layout toggle split";

          "${mod}+a" = "focus parent";

          "${mod}+f" = "fullscreen toggle";

          "${mod}+s" = "layout stacking";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+v" = "layout toggle splitv splith";
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
        };

      modes = {
        resize = {
          h = "resize shrink width 20 px";
          j = "resize grow height 20 px";
          k = "resize shrink height 20 px";
          l = "resize grow width 20 px";
          Escape = "mode default";
          Return = "mode default";
        };
      };
    };
    extraConfig = ''
      focus_on_window_activation focus
      workspace 1 output DP-1
      workspace 2 output DP-1
      workspace 3 output DP-1
      workspace 4 output HDMI-A-1
      workspace 5 output HDMI-A-1
      workspace 6 output HDMI-A-1
      default_border pixel 1
      default_floating_border pixel 1
      for_window [app_id=ghostty] focus
      for_window [app_id=neovide] focus

      set $left h
      set $down j
      set $up k
      set $right l

      bindsym ${mod}+$left focus left
      bindsym ${mod}+$down focus down
      bindsym ${mod}+$up focus up
      bindsym ${mod}+$right focus right
      # Or use ${mod}+[up|down|left|right]
      bindsym ${mod}+Left focus left
      bindsym ${mod}+Down focus down
      bindsym ${mod}+Up focus up
      bindsym ${mod}+Right focus right
      # Move the focused window with the same, but add Shift
      bindsym ${mod}+Shift+$left move left
      bindsym ${mod}+Shift+$down move down
      bindsym ${mod}+Shift+$up move up
      bindsym ${mod}+Shift+$right move right
      # Ditto, with arrow keys
      bindsym ${mod}+Shift+Left move left
      bindsym ${mod}+Shift+Down move down
      bindsym ${mod}+Shift+Up move up
      bindsym ${mod}+Shift+Right move right
    '';

  };
}
