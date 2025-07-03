{ inputs, pkgs, ... }:
{
  services.udev = {
    enable = true;
    packages = [
      inputs.openocd-rpi.packages.${pkgs.system}.openocd-raspberrypi
    ];

    extraRules =
      ''''
      + (builtins.readFile ./70-picotool.rules)
      + (builtins.readFile ./40-hpet-permissions.rules)
      + (builtins.readFile ./60-ioschedulers.rules)
      + (builtins.readFile ./99-cpu-dma-latency.rules)
      + (builtins.readFile ./99-platformio-udev.rules);
  };
}
