{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./environment.nix
    ./fuzzel.nix
    ./hyprland
  ];

  home.packages = with pkgs; [
    grim
    slurp
    brightnessctl
    wl-clipboard
    wl-screenrec
    clipse
    wlr-randr
    libnotify
    xdg-utils
  ];

}
