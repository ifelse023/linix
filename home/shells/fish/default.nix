{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (pkgs)
    eza
    bat
    sad
    fd
    fzf
    ;
in
{

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting ""
    '';
    # plugins = [
    #
    # ];
    shellAliases = {
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      shell = "nix shell";
      nsp = "nix-shell -p";

      cat = "${getExe bat} --style=plain";
      mp = "mkdir -p";
      ls = "${getExe eza} -h --git --icons=always";
      l = "ls -lF --time-style=long-iso --icons=always";

      errors = "journalctl -b -p err..alert";
      la = "${getExe eza} -ah --git --icons";
      tree = "${getExe eza} --tree --icons=never";
      burn = "pkill -9";
      diff = "diff --color=auto";
      killall = "pkill";
      baty = "sudo tlp-stat -b";
      sta = "printf '%s\n' $status";
      x = "hx";

      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };

    functions = {
      vim = "uwsm app -- neovide $argv";
      sr = ''
        if test (count $argv) -lt 2
            echo "Usage: sr <pattern> <replacement> [path]"
            return 1
        end
        set pattern $argv[1]
        set replacement $argv[2]
        set path "."
        if test (count $argv) -ge 3
            set path $argv[3]
        end
        ${getExe fd} --type f --hidden --exclude .git --exclude node_modules --exclude target --exclude .cache -0 . $path | ${getExe sad} -0 $pattern $replacement
      '';

      xx = ''
        set file (${getExe fd} --type f --hidden --exclude .git | ${getExe fzf}  --preview '${getExe bat} --color=always --style=numbers {}')
        if test -n "$file"
            uwsm app -- hx "$file"
        end
      '';

      y = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        		builtin cd -- "$cwd"
        	end
        	rm -f -- "$tmp"
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
