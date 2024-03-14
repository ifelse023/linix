{
  lib,
  config,
  ...
}: {
  services = {
    thermald = {
      enable = lib.mkDefault true;
    };

    power-profiles-daemon.enable = true;

    acpid.enable = true;

    # battery info
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };
  };
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      cpupower
    ];
  };
}
