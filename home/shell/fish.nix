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
    loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';
    interactiveShellInit = ''
      set fish_greeting ""
      if not set -q ZELLIJ; and pgrep -x .Hyprland-wrapp >/dev/null; and not pgrep -x zellij >/dev/null
          if set -q ZELLIJ_AUTO_ATTACH; and test "$ZELLIJ_AUTO_ATTACH" = true
              zellij attach -c
          else
              zellij
          end

          # Auto exit the shell session when Zellij exits
          set -q ZELLIJ_AUTO_EXIT; and test "$ZELLIJ_AUTO_EXIT" = true; and exit
      end
    '';
    plugins = [
      {
        name = "fifc";
        inherit (pkgs.fishPlugins.fifc) src;
      }
    ];

    shellAliases = {
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      run = "nix run";
      search = "nix search";
      shell = "nix shell";
      nsp = "nix-shell -p";

      # quality of life aliases
      cat = "${getExe bat} --style=plain";
      grep = "${getExe ripgrep}";
      du = "${getExe dust}";
      ps = "${getExe procs}";
      mp = "mkdir -p";
      fcd = "cd $(fd -type d | fzf)";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      l = "ls -lF --time-style=long-iso --icons";

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

      vim = "neovide";

      # faster navigation
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };
  };
}
