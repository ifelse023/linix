{ pkgs, lib, ... }:

{

  services.xserver.videoDrivers = lib.mkDefault [ "intel" ];
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "i915.enable_guc=3" ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  chaotic.mesa-git = {
    enable = true;
    method = "replaceRuntimeDependencies";
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      mesa
      vaapiIntel
      vaapiVdpau
    ];
  };
}
