{ pkgs, lib, ... }:
let
  mod = "Mod4";

  inherit (lib) getExe;
in
{
  wayland.windowManager.sway = {
    extraConfig = ''

      workspace 1 output eDP-1
      workspace 2 output eDP-1
      workspace 3 output eDP-1
      workspace 4 output HDMI-A-1
      workspace 5 output HDMI-A-1
      workspace 6 output HDMI-A-1
      workspace 7 output HDMI-A-1

      default_border pixel 1
      default_floating_border pixel 1

      # Move your focus around
      #
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

    config =

      {
        keybindings =
          {

            XF86MonBrightnessUp = "exec ${getExe pkgs.brightnessctl} set 10%-";
            XF86MonBrightnessDown = "exec ${getExe pkgs.brightnessctl} set +10%";
          }

          // {
            "${mod}+Return" = "exec ${getExe pkgs.foot}";

            "${mod}+d" = "exec fuzzel";

            Print = "exec ${getExe pkgs.flameshot} gui";

          }

          // {
            # quit/restart sway
            "${mod}+Shift+e" = "exec ${pkgs.sway_git}/bin/swaymsg exit";
            "${mod}+Shift+r" = "reload";

            # kill window
            "${mod}+q" = "kill";

            # alternate between the tiled and monocle layout
            "${mod}+z" = "layout toggle splith tabbed";

            # Cycle through the nodes (leaves only) of the current desktop
            "${mod}+space" = "exec ${pkgs.i3-cycle-focus}/bin/i3-cycle-focus cycle";

            # Back and forth desktop
            "${mod}+b" = "workspace back_and_forth";

            "${mod}+Shift+p" = "move workspace to output right";

            # Layout stuff:
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
  };
}
