{ pkgs, config, ... }:
let
  cfg = config.programs.git;
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFvLLdVK+G3HBsK6kKcVY4Ub98431EQLj0z9mo3CozUK light";
in
{
  home.packages = with pkgs; [ lazygit ];
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
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userEmail = "ifelse023@gmail.com";
      userName = "ifelse023";

      extraConfig = {
        delta = {
          enable = true;
          options.dark = true;
          line-numbers = true;
          options.navigate = true;
          features = "decorations side-by-side navigate";
        };

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
        ".ccls-cache/"
        ".idea/"
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
