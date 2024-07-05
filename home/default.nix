{ inputs, ... }:
{
  imports = [
    ./programs
    ./shell
    ./wm
    ./editors
    ./foot.nix
    inputs.chaotic.homeManagerModules.default
  ];

  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  news.display = "silent";

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  home = {
    username = "wasd";
    homeDirectory = "/home/wasd";

    #extraOutputsToInstall = ["doc" "devdoc"];

    stateVersion = "24.11";
  };
}
