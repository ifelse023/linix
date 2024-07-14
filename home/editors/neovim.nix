{
  pkgs,
  inputs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    #plugins = with pkgs.vimPlugins; [
    #];

    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      nil
      nixfmt-rfc-style
    ];
  };
}
