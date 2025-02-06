{ pkgs, inputs, ... }:

let
  nvim = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default.overrideAttrs (attrs: {
    inherit (attrs) cmakeFlagsArray;
    NIX_CFLAGS_COMPILE = "-march=native -O3";
    NIX_LDFLAGS = "-fuse-ld=mold";
    hardeningDisable = [ "all" ];
    nativeBuildInputs = attrs.nativeBuildInputs ++ [
      pkgs.mold-wrapped
      pkgs.pkgsx86_64_v3-core.gcc
    ];
  });

in
{
  programs.neovim = {
    enable = true;
    withRuby = false;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      nil
      nixfmt-rfc-style
      pkgs.pkgsx86_64_v3-core.gcc
    ];
  };
}
