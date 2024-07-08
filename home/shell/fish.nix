{ pkgs, lib, ... }:
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
    interactiveShellInit = ''
      set fish_greeting ""
    '';
    plugins = [
      {
        name = "fifc";
        inherit (pkgs.fishPlugins.fzf-fish) src;
      }
    ];
    shellAliases = {
      # nix specific aliases
      cleanup = "sudo nix-collect-garbage --delete-older-than 3d && nix-collect-garbage -d";
      bloat = "nix path-info -Sh /run/current-system";
      curgen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      repair = "nix-store --verify --check-contents --repair";
      run = "nix run";
      search = "nix search";
      shell = "nix shell";
      nsp = "nix-shell -p";
      nhs = "nh os switch -v";
      nhb = "nh os boot -v";

      # quality of life aliases
      cat = "${getExe bat} --style=plain";
      grep = "${getExe ripgrep}";
      du = "${getExe dust}";
      ps = "${getExe procs}";
      mp = "mkdir -p";
      fcd = "cd $(fd -type d | fzf)";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      l = "ls -lF --time-style=long-iso --icons";

      c = "yazi";

      # system aliases
      sc = "sudo systemctl";
      jc = "sudo journalctl";
      scu = "systemctl --user ";
      jcu = "journalctl --user";
      errors = "journalctl -p err..alert";
      la = "${getExe eza} -ah --git --icons --color=auto --group-directories-first -s extension";
      tree = "${getExe eza} --tree --icons=always";
      burn = "pkill -9";
      diff = "diff --color=auto";
      cpu = ''watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'';
      killall = "pkill";

      py = "python";

      # faster navigation
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };
  };
}
