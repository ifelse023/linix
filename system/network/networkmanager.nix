{pkgs, ...}: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";

    wifi = {
    };
  };
  services.resolved.enable = true;

  # wifi = {
  #   macAddress = "random";
  #   powersave = true;
  # };
}
