{ pkgs, ... }:
{
  services.scx = {
    enable = true;
    scheduler = "scx_rusty";
    package = pkgs.scx_git.full;
  };
}
