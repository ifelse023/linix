{
  pkgs,
  ...
}:
{
  imports = [ ./languages.nix ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs.helix_git;
    extraPackages = [
      pkgs.shellcheck
      pkgs.nil
    ];
    ignores = [
      "build/"
      "!.gitignore"
    ];
    settings = {
      editor = {
        file-picker.hidden = false;
        color-modes = true;
        completion-trigger-len = 1;
        completion-replace = true;
        line-number = "relative";
        shell = [
          "bash"
          "-c"
        ];
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          character = "▏";
          render = true;
        };
        lsp.display-inlay-hints = true;
        true-color = true;
        whitespace.characters = {
          newline = "↴";
          tab = "⇥";
        };
      };
      keys.normal."C-y" = [
        ":sh rm -f /tmp/unique-file"
        ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
        ":insert-output echo \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
        ":open %sh{cat /tmp/unique-file}"
        ":redraw"
      ];

    };
  };
}
