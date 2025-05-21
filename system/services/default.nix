{ pkgs, ... }:
{
  imports = [
    ./udev
    ./sound.nix
    ./keyd.nix
    ./power.nix
    ./openssh.nix
    ./location.nix
    ./tty.nix
    ./greetd.nix
    ./scx.nix
  ];

  services = {
    dbus = {
      implementation = "broker";
      packages = [ pkgs.gcr ];
    };
    gnome.gnome-keyring.enable = true;
    fstrim.enable = true;
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
  };
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true;
}
