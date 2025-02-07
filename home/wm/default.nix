{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./environment.nix
    ./fuzzel.nix
    ./hyprland
    # ./sway
  ];

  home.packages = with pkgs; [
    grim
    slurp
    brightnessctl
    wl-clipboard
    wl-screenrec
    wlr-randr
    libnotify
    cliphist
    xdg-utils
  ];

  services.cliphist = {
    enable = true;
  };
}
