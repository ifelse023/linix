{...}: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  # wifi = {
  #   macAddress = "random";
  #   powersave = true;
  # };
}
