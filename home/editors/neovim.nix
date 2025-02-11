{ pkgs, inputs, ... }:

{
  programs = {
    neovim = {
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

    neovide = {
      enable = true;

      settings = {
        font = {
          normal = [ "JetBrains Mono" ];
          size = 14.0;
          edging = "antialias";
          hinting = "full";
        };
      };
    };
  };
}
