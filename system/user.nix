{ pkgs, lib, ... }: {
  programs = {
    fuse.userAllowOther = true;
    dconf.enable = true;
  };

  users = {
    mutableUsers = false;
    users = {
      wasd = {
        isNormalUser = true;
        hashedPasswordFile = "/persist/secrets/wasd";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYw95sYKrLZ3B/OFytcoISEe0CMX6vcRE72VhIruOdC ifelse023@gmail.com"
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
    # userland niceness
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
