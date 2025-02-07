{ pkgs, lib, ... }:
{

  home.sessionVariables.SHELLS = lib.getExe pkgs.nushell;
  xdg.configFile = {
    "nushell/zoxide.nu".source = pkgs.runCommand "zoxide.nu" { } ''
      ${lib.getExe pkgs.zoxide} init nushell --cmd cd > $out
    '';

    "nushell/starship.nu".source = pkgs.runCommand "starship.nu" { } ''
      ${lib.getExe pkgs.starship} init nu > $out
    '';

    "nushell/ls_colors.txt".source = pkgs.runCommand "ls_colors.txt" { } ''
      ${lib.getExe pkgs.vivid} generate catppuccin-mocha > $out
    '';
  };

  programs.nushell = {
    enable = true;
    configFile.source = ./configuration.nu;
    envFile.source = ./environment.nu;

    shellAliases = {
      vi = "neovide";
      vim = "neovide";
      ll = "ls --long";
      la = "ls --all";

      cp = "cp --recursive --verbose --progress";
    };

  };
}
