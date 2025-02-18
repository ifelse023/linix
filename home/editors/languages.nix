{ lib, pkgs, ... }:
{
  programs.helix.languages = {
    language = [
      {
        name = "nix";
        auto-format = true;
      }
    ];
    language-server.nil = {
      config = {
        nil = {
          formatting.command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
        };
      };
    };
  };
}
