{ inputs, lib, ... }:
let
  inherit (lib) forEach;
in
{
  imports = [ inputs.impermanence.nixosModule ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      forEach [
        "NetworkManager"
        "nix"
        "ssh"
      ] (x: "/etc/${x}")
      ++ forEach [
        "nixos"
        "pipewire"
        #"fail2ban"
      ] (x: "/var/lib/${x}");
    files = [ "/etc/machine-id" ];
  };

  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume to a pristine state";
    wantedBy = [ "initrd.target" ];
    requires = [ "dev-disk-by\\x2dlabel-NIXOS.device" ];
    after = [ "dev-disk-by\\x2dlabel-NIXOS.device" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
        mkdir -p /mnt

      mount -o subvol=/ /dev/disk/by-label/NIXOS /mnt


        btrfs subvolume list -o /mnt/root |
          cut -f9 -d' ' |
          while read subvolume; do
            echo "deleting /$subvolume subvolume..."
            btrfs subvolume delete "/mnt/$subvolume"
          done &&
          echo "deleting /root subvolume..." &&
          btrfs subvolume delete /mnt/root

        echo "restoring blank /root subvolume..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root

        umount /mnt
    '';
  };

  systemd.tmpfiles.rules = [
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];
}
