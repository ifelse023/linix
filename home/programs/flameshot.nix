{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (_final: prev: {
      flameshot = prev.flameshot.overrideAttrs (oldAttrs: {
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
      });
    })
  ];
  home.packages = [
    pkgs.flameshot
  ];
}
