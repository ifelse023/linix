{ pkgs, lib, ... }:
{
  programs = {
    fuse.userAllowOther = true;
    dconf.enable = true;
  };

  users = {
    mutableUsers = false;
    users = {
      wasd = {
        isNormalUser = true;
        hashedPasswordFile = "/persist/passwd";
        shell = pkgs.nushell;
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
          "nix"
        ];
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    # don't ask for password for wheel group
    sudo = {
      wheelNeedsPassword = false;
      # only allow members of the wheel group to execute sudo
      # by setting the executable’s permissions accordingly
      execWheelOnly = lib.mkForce true;
    };
  };

}
