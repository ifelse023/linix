{
  programs.fish = {
    shellAliases = {
      zj = "zellij";
    };
    interactiveShellInit = ''
      if not set -q ZELLIJ; and pgrep -x "sway"  > /dev/null; and not pgrep -x "zellij"  > /dev/null
          if set -q ZELLIJ_AUTO_ATTACH; and test "$ZELLIJ_AUTO_ATTACH" = "true"
              zellij attach -c
          else
              zellij
          end

          # Auto exit the shell session when Zellij exits
          set -q ZELLIJ_AUTO_EXIT; and test "$ZELLIJ_AUTO_EXIT" = "true"; and exit
      end
    '';
  };
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  programs.zellij = {
    enable = true;
  };
}
