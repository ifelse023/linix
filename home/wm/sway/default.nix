{ lib, pkgs, ... }:
{
  imports = [ ./keybindings.nix ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = false;
    checkConfig = false;
    package = pkgs.sway_git;

    wrapperFeatures.gtk = true;

    config = {
      output = {
        "*" = {
          scale = "1";
          adaptive_sync = "off";
          max_render_time = "5";
        };
        HDMI-A-1 = {
          position = "1920,0";
          mode = "1920x1080@60Hz";
        };
        eDP-1 = {
          position = "0,0";
          mode = "1920x1080@60Hz";
        };
      };
      assigns = {
        "number 4" = [ { app_id = "firefox-nightly"; } ];
        "number 8" = [ { app_id = "discord"; } ];
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
        inner = 3;
        smartGaps = true;
        smartBorders = "on";
      };

      startup = [
        {
          command =
            let
              wallpaper = pkgs.fetchurl {
                url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-mocha.png";
                sha256 = "7e6285630da06006058cebf896bf089173ed65f135fbcf32290e2f8c471ac75b";
              };
              setWallpaper = pkgs.writeShellScript "set-wallpaper" ''
                uwsm app -- ${lib.getExe pkgs.killall} swaybg
                uwsm app -- ${lib.getExe pkgs.swaybg} -m fill -i ${wallpaper}
              '';
            in
            "${setWallpaper}";
          always = true;
        }
        { command = "uwsm app -- firefox-nightly"; }

      ];
    };
  };
}
