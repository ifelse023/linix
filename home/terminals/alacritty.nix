{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty_git;
    # settings = {
    # };
  };
}
