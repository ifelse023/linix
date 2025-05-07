{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./environment.nix
    ./fuzzel.nix
    ./sway
  ];

  home.packages = [
    pkgs.grim
    pkgs.swayr
    pkgs.slurp
    pkgs.brightnessctl
    pkgs.wl-clipboard
    pkgs.wl-screenrec
    pkgs.clipse
    pkgs.wlr-randr
    pkgs.libnotify
    pkgs.xdg-utils
  ];

}
