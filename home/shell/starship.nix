{ config, lib, ... }:
let
  inherit (builtins) map;
  inherit (lib.strings) concatStrings;
in
{
  home = {
    sessionVariables = {
      STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
    };
  };

  programs.starship =
    let
      elemsConcatted = concatStrings (
        map (s: "\$${s}") [
          "hostname"
          "username"
          "directory"
          "shell"
          "nix_shell"
          "git_branch"
          "git_commit"
          "git_state"
          "git_status"
          "jobs"
          "cmd_duration"
        ]
      );
    in
    {
      enable = true;

      settings = {
        scan_timeout = 2;
        command_timeout = 2000; # nixpkgs makes starship implode with lower values
        add_newline = false;
        line_break.disabled = false;

        format = "${elemsConcatted}\n$character";

        hostname = {
          ssh_only = true;
          disabled = false;
          format = "@[$hostname](bold #89b4fa) "; # the whitespace at the end is actually important
        };

        # configure specific elements
        character = {
          error_symbol = "[[󰋕](bold #f38ba8) ❯](bold #f38ba8)";
          success_symbol = "[[󰋕](bold #a6e3a1) ❯](bold #b4befe)";
          vicmd_symbol = "[](bold #f9e2af)";
          format = "$symbol ";
        };

        username = {
          format = "[$user]($style) in ";
        };

        directory = {
          truncation_length = 6;
          read_only_style = "197";
          home_symbol = "󰋜 ~";
          read_only = "  ";
          # removes the read_only symbol from the format, it doesn't play nicely with my folder icon
          format = "[ ](bold #a6e3a1) [$path]($style) ";

          # the following removes tildes from the path, and substitutes some folders with shorter names
          substitutions = {
            "~/Dev" = "dev";
            "~/Documents" = "Docs";
          };
        };

        # git
        git_commit.commit_hash_length = 7;
        git_branch.style = "bold #eba0ac";
        git_status = {
          style = "#f38ba8";
          ahead = "⇡ ";
          behind = "⇣ ";
          conflicted = " ";
          renamed = "»";
          deleted = "✘ ";
          diverged = "⇆ ";
          modified = "!";
          stashed = "≡";
          staged = "+";
          untracked = "?";
        };

        # language configurations
        # the whitespaces at the end *are* necessary for proper formatting
        lua.symbol = "[ ](#89b4fa) ";
        python.symbol = "[ ](#89b4fa) ";
        rust.symbol = "[ ](#f38ba8) ";
        nix_shell.symbol = "[ ](#89b4fa) ";
        golang.symbol = "[󰟓 ](#89b4fa)";
        c.symbol = "[ ](#1e1e2e)";
        nodejs.symbol = "[󰎙 ](#f9e2af)";

        package.symbol = " ";
      };
    };
}
