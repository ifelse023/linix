{ pkgs, inputs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      withRuby = false;
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

  };
}
