{ inputs, ... }:
{
  imports = [
    ./programs
    ./shell
    ./wm
    ./editors
    ./terminals
    inputs.chaotic.homeManagerModules.default
  ];

  programs = {
    home-manager.enable = true;
  };

  # reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  news.display = "silent";

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  home = {
    username = "wasd";
    homeDirectory = "/home/wasd";
    stateVersion = "25.05";
  };
}
