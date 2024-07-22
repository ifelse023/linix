{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "*" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
