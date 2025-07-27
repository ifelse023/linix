{
  pkgs,
  lib,
  ...
}:
let
  functions = ./functions.fish;
  inherit (lib.meta) getExe;
  inherit (pkgs)
    bat
    eza
    fd
    fzf
    ;
in
{
  home.packages = [ pkgs.fish-lsp ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      source ${functions}
      set fish_greeting ""
    '';

    shellAliases = {
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      cat = "${getExe bat} --style=plain";
      mp = "mkdir -p";
      ls = "${getExe eza} -h --git -s extension";
      l = "ls -lF --time-style=long-iso";
      ll = "eza -l --git --color=auto";
      errors = "journalctl -b -p err..alert";
      la = "${getExe eza} -ah --git";
      tree = "${getExe eza} --tree --icons=never";
      burn = "pkill -9";
      diff = "diff --color=auto";
      killall = "pkill";
      baty = "sudo tlp-stat -b";
      sta = "printf '%s\n' $status";
      x = "nvim";

      objdump = "llvm-objdump";
      readelf = "llvm-readelf";
      nm = "llvm-nm";
      strings = "llvm-strings";
      addr2line = "llvm-addr2line";
      size = "llvm-size";
      strip = "llvm-strip";
      ar = "llvm-ar";
      ranlib = "llvm-ranlib";

      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };
    shellAbbrs = {
      n = "nvim";
      j = "just";
      py = "python";
    };

    functions = {
      vim = "uwsm app -- neovide $argv";

      xx = ''
        set file (${getExe fd} --type f --hidden --exclude .git | ${getExe fzf}  --preview '${getExe bat} --color=always --style=numbers {}')
        if test -n "$file"
          uwsm app -- neovide "$file"
        end
      '';

      fcd = ''
        set dir (${getExe fd} --type d --hidden --exclude .git | ${getExe fzf} --preview '${getExe eza} --tree --level=1 --color=always {}')
        if test -n "$dir"
          cd "$dir"
        end
      '';
    };
  };
}
