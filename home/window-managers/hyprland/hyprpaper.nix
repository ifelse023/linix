{ pkgs, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/1p/wallhaven-1p5z71.jpg";
    hash = "sha256-y+SjxTg9VfhfcZoIm7qdgJyDkOFJ1Gau6A4luXIifxY=";
  };
in
{
  services.hyprpaper = {
    enable = true;
    # package = inputs.hyprpaper.packages.${pkgs.system}.default;

    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ ", ${wallpaper}" ];
    };
  };
}
