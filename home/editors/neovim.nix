{ pkgs, inputs, ... }:

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
      gcc
    ];
  };
}
