{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (pkgs)
    bat
    eza
    fd
    fzf
    gawk
    rsync
    sad
    unzip
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
      gdb = "gdb-dashboard";

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
          uwsm app -- nvim "$file"
        end
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

      "clean-unzip" = ''
        function clean-unzip --argument zipfile
          if not test (string ends-with ".zip" -- "$zipfile")
            echo (status function): argument must be a .zip file >&2
            return 1
          end
          if not test -f "$zipfile"
              echo (status function): file not found -- "$zipfile" >&2
              return 1
          end

          # Check if the zip archive has a single root directory.
          set -l root_entries (zipinfo -1 "$zipfile" | ${getExe gawk} -F/ '{print $1}' | uniq | wc -l)

          if test $root_entries -eq 1
            # Archive is clean, extract directly.
            ${getExe unzip}$zipfile
          else
            # Archive has multiple root entries, create a directory.
            set folder_name (string trim -r -c ".zip" -- "$zipfile")
            set target (basename "$folder_name")
            mkdir -p -- "$target" || return 1
             ${getExe unzip} $zipfile -d "$target"
          end
        end
      '';

      "mkdir-cd" = ''
        function mkdir-cd --argument dir
          mkdir -p -- "$dir"; and cd -- "$dir"
        end
      '';

      restore = ''
        function restore --argument-names file
          if not string ends-with -- ".bak" "$file"
            echo "Usage: restore <file.bak>" >&2
            return 1
          end
          set original (string replace ".bak" "" -- "$file")
          mv -- "$file" "$original"
        end
      '';

      backup = ''
        function backup --argument-names filename
          cp -rv -- "$filename" "$filename.bak"
        end
      '';

      cpr = ''
        function cpr
          ${getExe rsync} -aHAX --info=NAME,PROGRESS2 --human-readable --no-inc-recursive -- $argv
        end
      '';

      "echo-variable" = ''
        function echo-variable --no-scope-shadowing
          set -l varname
          if set -q -- $argv[1]
            set varname $argv[1]
          else
            set varname (string upper -- $argv[1])
          end

          if set -q -- $varname
            # Use printf for more reliable output, especially with edge cases.
            printf '%s\n' "$$varname"
          else
            echo "Variable '$argv[1]' (or '$varname') not found." >&2
            return 1
          end
        end
      '';
    };
  };
}
