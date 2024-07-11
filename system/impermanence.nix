{ inputs, lib, ... }:
let
  inherit (lib) forEach;
in
{
  imports = [ inputs.impermanence.nixosModule ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      forEach [ "nix" ] (x: "/etc/${x}")
      ++ forEach [
        "nixos"
        "pipewire"
        "/systemd"
        #"fail2ban"
        "iwd"
      ] (x: "/var/lib/${x}");
    files = [ "/etc/machine-id" ];
    users.wasd = {
      directories =
        [
          "linix"
          "Downloads"
          "misc"
          "dev"
          ".cache"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          ".mozilla"
        ]
        ++ forEach [ "Vesktop" ] (x: ".config/${x}")
        ++ forEach [
          "atuin"
          "fish"
          "nvim"
        ] (x: ".local/share/${x}")
        ++ [ ];
    };
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
}
