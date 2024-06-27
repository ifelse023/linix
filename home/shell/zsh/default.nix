{ config, ... }:
{
  imports = [
    ./aliases.nix
    ./init.nix
    ./plugins.nix
    ./starship.nix
  ];

  config = {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true; # we handle this ourself
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        LC_ALL = "en_US.UTF-8";
      };

      history = {
        # share history between different zsh sessions
        share = true;

        # avoid cluttering $HOME with the histfile
        path = "${config.xdg.dataHome}/zsh/zsh_history";

        # saves timestamps to the histfile
        extended = true;

        # optimize size of the histfile by avoiding duplicates
        # or commands we don't need remembered
        save = 10000;
        size = 10000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        ignorePatterns = [
          "rm *"
          "pkill *"
          "kill *"
          "killall *"
        ];
      };

      # dirhashes are easy aliases to commonly used directoryies
      # e.g. `cd ~dl` would take you to $HOME/Downloads
      dirHashes = {
        docs = "$HOME/Documents";
        dl = "$HOME/Downloads";
        dev = "$HOME/dev";
        dots = "$HOME/linix";
      };

      # Disable /etc/{zshrc,zprofile} that contains the "sane-default" setup out of the box
      # in order avoid issues with incorrect precedence to our own zshrc.
      # See `/etc/zshrc` for more info.
      envExtra = ''
        setopt no_global_rcs
      '';
    };
  };
}
