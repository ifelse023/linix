{ pkgs, inputs, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/ifelse023/architect/main/wallpapers/wave.png";
    hash = "sha256-VxfOERITyt+8Ayjbu4PyTyNh6YXVeANV1StYyM0uCUg=";
  };
in
{
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;

    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ ", ${wallpaper}" ];
    };
  };
}
