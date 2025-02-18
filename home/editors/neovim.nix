{ pkgs, inputs, ... }:

{
  programs = {
    neovim = {
      enable = true;
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
