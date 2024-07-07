{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./keybindings.nix ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    package =
      let
        cfg = config.wayland.windowManager.sway;
      in
      pkgs.sway_git.override {
        inherit (cfg) extraSessionCommands extraOptions;
        withBaseWrapper = cfg.wrapperFeatures.base;
        withGtkWrapper = cfg.wrapperFeatures.gtk;
      };
    wrapperFeatures.gtk = true;
    config = {

      output =
        lib.genAttrs
          [
            "eDP-1"
            "HDMI-A-1"
          ]
          (_: {
            adaptive_sync = "off";
          });
      assigns = {
        "number 4" = [ { app_id = "firefox"; } ];
        "number 8" = [ { app_id = "discord"; } ];
      };

      floating.criteria = [
        { app_id = "pavucontrol"; }
        { app_id = "flameshot"; }
        { app_id = "^(.*) Indicator"; }
        { app_id = "Picture-in-Picture"; }
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
                ${lib.getExe pkgs.killall} swaybg
                ${lib.getExe pkgs.swaybg} -m fill -i ${wallpaper}
              '';
            in
            "${setWallpaper}";
          always = true;
        }
      ];
    };
  };
}
