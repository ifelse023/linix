{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-gpu-intel
  ];
  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = [];
  };

  hardware.cpu.intel.updateMicrocode = true;
  environment.systemPackages = with pkgs; [intel-gpu-tools];
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
    ];
  };
}
