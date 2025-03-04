{
  config,
  lib,
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
        default_session = session;
        initial_session = session;
      };
    };

  programs.uwsm = {
    enable = true;

  };

}
