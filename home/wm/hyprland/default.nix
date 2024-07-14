{ inputs, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./binds.nix
    ./rules.nix
    ./config.nix
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  home.packages = [ inputs.hyprland-contrib.packages.${pkgs.system}.grimblast ];
  wayland.windowManager.hyprland = {
    enable = true;
    # xwayland.enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
