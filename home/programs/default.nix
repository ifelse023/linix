{
  pkgs,
  lib,
  hostname,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./scripts
    ./xdg.nix
    ./gtk.nix
    ./zathura.nix
    # ./flameshot.nix
  ]
  ++ lib.optionals (hostname == "light") [
    ./light.nix
  ];

  home.packages = [
    pkgs.pwvucontrol_git
    pkgs.obsidian
    pkgs.anki
  ];
}
