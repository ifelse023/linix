{ pkgs, config, ... }:
let
  cfg = config.programs.git;
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMqPLz1VVjaPGsWaeAUnajDs/1awhmQLluvf+J+O9BOa light";
in
{
  home.packages = [ pkgs.lazygit ];
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.enable = false;
      # extensions = with pkgs; [
      #   gh-dash # dashboard with pull requests and issues
      #   gh-eco # explore the ecosystem
      #   gh-cal # contributions calender terminal viewer
      # ];
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    git = {
      enable = true;
      userEmail = "ifelse023@gmail.com";
      userName = "ifelse023";
      delta = {
        enable = true;
        options.dark = true;
      };

      extraConfig = {

        init.defaultBranch = "main";
        diff.colorMoved = "default";
        merge.conflictstyle = "diff3";

        push = {
          default = "current";
          followTags = true;
        };

        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        color.ui = "auto";

        rebase = {
          autoSquash = true;
          autoStash = true;
        };

        rerere = {
          autoupdate = true;
          enabled = true;
        };
      };

      lfs.enable = true;

      ignores = [
        ".cache/"
        "*.swp"
        "*.elc"
        ".~lock*"
        "auto-save-list"
        ".direnv/"
        "node_modules"
        "result"
        "result-*"
      ];

      signing = {
        key = "${config.home.homeDirectory}/.ssh/id_ed25519";
        signByDefault = true;
      };

      extraConfig = {
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile =
            config.home.homeDirectory + "/" + config.xdg.configFile."git/allowed_signers".target;
        };

        pull.rebase = true;
      };
    };
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${cfg.userEmail} namespaces="git" ${key}
  '';
}
