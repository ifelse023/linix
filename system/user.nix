{ pkgs, lib,inputs, ... }:
{
  programs = {
    fuse.userAllowOther = true;
    dconf.enable = true;
    fish.enable = true;
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
          "networkmanager"
          "plugdev"
          "transmission"
          "video"
          "wheel"
          "systemd-journal"
          "power"
        ];
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    sudo = {
      wheelNeedsPassword = false;
      # only allow members of the wheel group to execute sudo
      # by setting the executable’s permissions accordingly
      execWheelOnly = lib.mkForce true;
    };
  };

}
