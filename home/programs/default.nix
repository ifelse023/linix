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
    pkgs.vscode.fhs
    # pkgs.obsidian
    # pkgs.jetbrains.idea-ultimate
  ];
}
