{
  pkgs,
  lib,
  ...
}: {
  programs = {
    fuse.userAllowOther = true;
    zsh.enable = true;
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
        extraGroups = ["input" "libvirtd" "networkmanager" "plugdev" "transmission" "video" "wheel" "systemd-journal" "power" "nix"];
      };
    };
  };
  security = {
    # userland niceness
    rtkit.enable = true;

    polkit.enable = true;

    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;
  };
  systemd.enableUnifiedCgroupHierarchy = lib.mkForce true;
}
