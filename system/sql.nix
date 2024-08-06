{ pkgs, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    initialDatabases = [
      {
        name = "memsql";
        # schema = pkgs.writeText "init.sql" ''
        #   CREATE TABLE entries (text TEXT);
        # '';
      }
    ];
    ensureUsers = [
      {
        name = "wasd";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
