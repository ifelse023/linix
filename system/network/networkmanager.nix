_:
{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    dns = "systemd-resolved";

    wifi = { };
  };
  services.resolved.enable = true;

  # wifi = {
  #   macAddress = "random";
  #   powersave = true;
  # };
}
