{pkgs, ...}:
# networking configuration
{
  imports = [./security.nix ./networkmanager.nix];

  systemd.network.wait-online.enable = false;

  environment.systemPackages = with pkgs; [
    ethtool

    # dns client
    dogdns

    wget
    curl
  ];
}
