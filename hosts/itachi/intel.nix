{
  pkgs,
  lib,
  config,
  ...
}:

{
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services = {
    throttled = {
      enable = lib.mkDefault true;
      extraConfig = ''
        [UNDERVOLT]           # all values in mV, *negative* numbers only
        CORE:   -100          # start-point –90 to –110 usually safe
        CACHE:  -100          # keep equal to CORE for stability
        GPU:    -60           # iGPU often wants ~40-80 mV
        UNCORE: -60           # aka System Agent
        ANALOGIO: 0           # rarely helps; leave at 0
      '';
    };

    undervolt.enable = false;
    xserver.videoDrivers = lib.mkDefault [ "intel" ];
  };

  boot = {
    kernel.sysctl = {
      "dev.i915.perf_stream_paranoid" = 0;
    };
    initrd.kernelModules = [
      "i915"
      "kvm-intel"
    ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "i915.enable_dc=0"
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.vaapiIntel
      pkgs.vaapiVdpau
      pkgs.libvdpau-va-gl
      pkgs.intel-compute-runtime-legacy1
    ];
  };
}
