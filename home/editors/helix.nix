{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ ./languages.nix ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = inputs.helix.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      shellcheck
      nil
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
    };
  };
}
