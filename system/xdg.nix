{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "*" ];
    };
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
}
