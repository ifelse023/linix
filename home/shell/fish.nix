{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (pkgs)
    eza
    bat
    ripgrep
    dust
    procs
    ;

in
{
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.concatStringsSep "\n" [
      (builtins.readFile "${inputs.tokyonight}/extras/fish/tokyonight_moon.fish")
      ''
        set fish_greeting ""
      ''
    ];
    # plugins = [
    #
    # ];
    #
    shellAliases = {
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      run = "nix run";
      search = "nix search";
      shell = "nix shell";
      nsp = "nix-shell -p";

      cat = "${getExe bat} --style=plain";
      grep = "${getExe ripgrep}";
      du = "${getExe dust}";
      ps = "${getExe procs}";
      mp = "mkdir -p";
      fcd = "cd $(fd -type d | fzf)";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      l = "ls -lF --time-style=long-iso --icons";

      errors = "journalctl -p err..alert";
      la = "${getExe eza} -ah --git --icons --color=auto --group-directories-first -s extension";
      tree = "${getExe eza} --tree --icons=always";
      burn = "pkill -9";
      diff = "diff --color=auto";
      cpu = ''watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'';
      killall = "pkill";

      py = "python";

      vim = "neovide";

      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };
  };
}
