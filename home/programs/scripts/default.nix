{ pkgs, lib, ... }:

let
  template = pkgs.writers.writePython3Bin "template" {
    flakeIgnore = [
      "E265"
      "E225"
      "E501"
      "E111"
      "E121"
    ];
  } ./template.py;

  openbook = pkgs.writers.writeBashBin "openbook" ''
    set -euo pipefail

    BOOK_DIR="$HOME/misc/books"
    cd "$BOOK_DIR" || exit 1

    selection=$(${lib.getExe pkgs.fd} -t f -e pdf -e epub | ${lib.getExe pkgs.fuzzel} -d --prompt 'Open Book: ' --width 80)

    if [ -n "$selection" ]; then
        ${lib.getExe pkgs.zathura} "$selection" &
    fi
  '';

in
{
  home.packages = [
    template
    openbook
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    bind = $mod, B, exec, ${openbook}/bin/openbook
  '';
}
