{ pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    withRuby = false;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    #plugins = with pkgs.vimPlugins; [
    #];

    extraPackages = with pkgs; [
      ripgrep
      fd
      pkgsx86_64_v3-core.gcc
      nil
      nixfmt-rfc-style
    ];
  };
}
