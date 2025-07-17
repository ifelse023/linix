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
      zellij_start
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

      zellij_start = ''
        if not status --is-interactive; or set -q ZELLIJ; or set -q SSH_TTY; or test "$ZELLIJ_START" = 0
            return
        end

        set -l sessions (zellij list-sessions --short 2>/dev/null)

        switch (count $sessions)
            case 0
                zellij
            case 1
                zellij attach $sessions[1]
            case '*'
                set -l choice (
                    begin
                        printf '%s\n' $sessions
                        printf '[NEW]\n[QUIT]\n'
                    end | fzf --prompt='zellij session> ' --height=40% --no-multi
                )

                switch $choice
                    case '[NEW]'
                        read -lP 'New session name: ' session_name
                        test -z "$session_name"; and zellij; or zellij attach --create $session_name
                    case '*'
                        zellij attach --create $choice
                end
        end
      '';

      z_kill_all = ''
        zellij kill-all-sessions -y
        zellij delete-all-sessions -y
      '';
    };
  };
}
