{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (_final: prev: {
      flameshot = prev.flameshot.overrideAttrs (oldAttrs: {
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-DUSE_WAYLAND_GRIM=ON -DUSE_WAYLAND_CLIPBOARD=true"
        ];
      });
    })
  ];
  home.packages = [
    pkgs.flameshot
  ];
}
