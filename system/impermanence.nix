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
        "nix"
        "ssh"
        "NetworkManager/system-connections"
      ] (x: "/etc/${x}")
      ++ forEach [
        "nixos"
        "iwd"
        "systemd/coredump"
        #"fail2ban"
      ] (x: "/var/lib/${x}");
    files = [ "/etc/machine-id" ];
  };

}
