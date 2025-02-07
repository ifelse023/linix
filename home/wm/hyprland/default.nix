{ inputs, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./binds.nix
    ./rules.nix
    ./config.nix
    ./hyprpaper.nix
  ];
  # home.packages = [ inputs.hyprland-contrib.packages.${pkgs.system}.grimblast ];
  wayland.windowManager.hyprland = {
    enable = true;
    # xwayland.enable = true;
    systemd = {
      enable = false;
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
