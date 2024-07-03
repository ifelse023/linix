{ config,lib, ... }: {

powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  services = {
    thermald = { enable = lib.mkDefault true; };

tlp.settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_MAX_PERF_ON_AC=100;
      CPU_MAX_PERF_ON_BAT=50;

      # My laptop is always plugged in wherever I'm willing to use it, so I'll
      # value battery lifespan over runtime. Run `tlp fullcharge` to temporarily
      # force full charge.
      # @see https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds
      START_CHARGE_THRESH_BAT0=60;
      STOP_CHARGE_THRESH_BAT0=70;
    };


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
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      cpupower
    ];
  };
}
