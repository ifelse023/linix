{ pkgs, lib, ... }:
{
  programs = {
    fuse.userAllowOther = true;
    dconf.enable = true;
    fish.enable = true;
  };

  users = {
    mutableUsers = false;
    users = {
      wasd = {
        isNormalUser = true;
        hashedPasswordFile = "/home/passwd";
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDiH2GdTFm3E7thrg5V2jjV78Xii9FdYHtosAtr9box light"
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

  services.getty.autologinUser = "wasd";
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
  environment = {
    shells = with pkgs; [ fish ];
  };
}
