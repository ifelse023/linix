{ pkgs, inputs, ... }:

{

  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim-nightly.packages.${pkgs.system}.default;
      withRuby = false;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      extraPackages = [
        pkgs.ripgrep
        pkgs.fd
        pkgs.nil
        pkgs.nixfmt-rfc-style
        pkgs.gcc
      ];
    };
  };
}
