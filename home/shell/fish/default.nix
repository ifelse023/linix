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

      zellij_start = ''
        if set -q ZELLIJ || set -q SSH_TTY
            return
        end

        set sessions (zellij list-sessions --short 2>/dev/null)

        if test (count $sessions) -eq 0
            zellij
        else if test (count $sessions) -eq 1
            echo "Attaching to existing session: $sessions[1]"
            zellij attach $sessions[1]
        else
            echo "Multiple zellij sessions found:"
            for i in (seq (count $sessions))
                echo "  $i) $sessions[$i]"
            end
            echo "  n) Create new session"
            echo "  q) Skip zellij and continue"

            read -P "Choose session (1-"(count $sessions)", n, q): " choice

            switch $choice
                case q Q
                    return
                case n N
                    read -P "Enter name for new session: " session_name
                    if test -z "$session_name"
                        zellij
                    else
                        zellij --session $session_name
                    end
                case '*'
                    if string match -qr '^\d+$' $choice
                        and test $choice -ge 1
                        and test $choice -le (count $sessions)
                        echo "Attaching to session: $sessions[$choice]"
                        zellij attach $sessions[$choice]
                    else
                        echo "Invalid choice. Skipping zellij."
                        return
                    end
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
