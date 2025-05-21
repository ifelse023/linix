{ pkgs, ... }:
{
  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;
  # services.qemuGuest.enable = true;
  # services.spice-vdagentd.enable = true;

  virtualisation.podman = {

    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = [ pkgs.distrobox ];
}
