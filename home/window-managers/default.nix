{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./environment.nix
    ./fuzzel.nix
    ./sway
  ];

    services.cliphist = {
      enable = true;
      extraOptions = [ "-max-items" "1000" ];
    };

  home.packages = [
    pkgs.grim
    pkgs.swayr
    pkgs.slurp
    pkgs.brightnessctl
    pkgs.wl-clipboard
    pkgs.wl-screenrec
    pkgs.wlr-randr
    pkgs.libnotify
    pkgs.xdg-utils
  ];

}
