{
  pkgs,
  lib,
  config,
  ...
}:

{
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.xserver.videoDrivers = lib.mkDefault [ "intel" ];
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
      "i915.enable_guc=3"
      "i915.enable_dc=0"
    ];

  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.intel-compute-runtime
      pkgs.intel-media-driver
      pkgs.vaapiIntel
      pkgs.vaapiVdpau
      pkgs.vpl-gpu-rt
      pkgs.libvdpau-va-gl
    ];
  };
}
