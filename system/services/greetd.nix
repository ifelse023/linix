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
        command = "${lib.getExe config.programs.uwsm.package} start default";
        user = "wasd";
      };
    in
    {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd fish";
        initial_session = session;
      };
    };

  programs.uwsm = {
    enable = true;
      waylandCompositors.sway = {
        prettyName = "Sway";
        comment = "Sway";
        binPath = "/etc/profiles/per-user/wasd/bin/sway";
      };

  };

}
