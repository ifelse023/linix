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
        pkgs.gcc
        pkgs.fd
        pkgs.nil
        pkgs.nixfmt-rfc-style
        pkgs.just-lsp
        pkgs.shfmt
        pkgs.fish-lsp
        pkgs.ast-grep
      ];
    };

    # neovide = {
    #   enable = true;
    #   settings = {
    #     neovim-bin = "${pkgs.neovim}/bin/nvim";
    #     font = {
    #       size = 16;
    #       normal = "JetBrainsMono Nerd Font Mono";
    #     };
    #     wsl = false;
    #     maximized = true;
    #   };
    # };
  };
}
