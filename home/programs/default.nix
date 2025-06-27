{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./scripts
    ./xdg.nix
    ./gtk.nix
    # ./flameshot.nix
  ];

  home.packages = [
    pkgs.vesktop
    pkgs.pwvucontrol_git
    pkgs.obsidian
  ];
}
