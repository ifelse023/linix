{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.greetd =
    let
      session = {
        command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
        user = "wasd";
      };
    in
    {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd fish -l";
        initial_session = session;
      };
    };

  programs = {
    uwsm = {
      enable = true;
      waylandCompositors.hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };

    };
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      withUWSM = true;
    };
  };
}
