{ inputs, ... }:
{
  imports = [
    inputs.chaotic.homeManagerModules.default
    ./programs
    ./shell
    ./window-managers
    ./editors
    ./emulators
  ];

  programs = {
    home-manager.enable = true;
  };

  systemd.user.startServices = "sd-switch";

  # news.display = "silent";

  nixpkgs.config = {
    allowUnfree = true;
  };

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  home = {
    username = "wasd";
    homeDirectory = "/home/wasd";
    stateVersion = "25.11";
  };
}
