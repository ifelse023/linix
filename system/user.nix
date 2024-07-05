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
        hashedPasswordFile = "/persist/secrets/wasd";
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSsqE4dZjz5NPzSbm7y3tlUG6kEKFarMaEcXhhw9FZg wasd"
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
  environment = {
    shells = with pkgs; [ fish ];
  };
}
