{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./xdg.nix
    ./media.nix
    ./gtk.nix
  ];
}
