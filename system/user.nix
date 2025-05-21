{
  pkgs,
  ...
}:
{
  programs = {
    fuse.userAllowOther = true;
    dconf.enable = true;
    fish.enable = true;
    nh = {
      enable = true;
      flake = "/home/wasd/linix";
    };
  };

  users = {
    mutableUsers = false;
    groups.plugdev = { };
    users = {
      wasd = {
        isNormalUser = true;
        hashedPasswordFile = "/persist/passwd";
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMqPLz1VVjaPGsWaeAUnajDs/1awhmQLluvf+J+O9BOa light"
        ];
        extraGroups = [
          "input"
          "libvirtd"
          "plugdev"
          "video"
          "wheel"
          "systemd-journal"
        ];
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      wheelNeedsPassword = false;
      execWheelOnly = true;
    };
  };
}
