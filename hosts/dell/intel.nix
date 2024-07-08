{ pkgs, lib, ... }:

{

  services.xserver.videoDrivers = lib.mkDefault [ "intel" ];
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "i915.enable_guc=3"
      "i915.fastboot=1"
    ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  environment.systemPackages = with pkgs; [ intel-gpu-tools ];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      mesa_git
    ];
  };

  chaotic.mesa-git = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vaapiIntel
    ];
  };

}
