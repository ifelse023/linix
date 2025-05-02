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
        maximized = true;
        fork = true;
        tabs = true;
        theme = "auto";
        title-hidden = true;
        vsync = false;
        wsl = false;
        font = {
          normal = [ "JetBrains Mono" ];
          size = 16.0;
        };
      };
    };
  };
}
