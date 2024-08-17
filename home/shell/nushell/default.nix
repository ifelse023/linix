{ pkgs, lib, ... }:
{

  home.sessionVariables.SHELLS = lib.getExe pkgs.nushell;
  xdg.configFile = {
    "nushell/zoxide.nu".source = pkgs.runCommand "zoxide.nu" { } ''
      ${lib.getExe pkgs.zoxide} init nushell --cmd cd > $out
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
    };

  };
}
