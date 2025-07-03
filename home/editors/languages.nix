{ lib, pkgs, ... }:
{
  programs.helix.languages = {
    language = [
      {
        name = "c";
        auto-format = true;
        formatter = {
          command = "${pkgs.clang-tools}/bin/clang-format";
        };
      }
      {
        name = "nix";
        auto-format = true;
      }
    ];
    language-server = {

      clangd = {
        command = "${pkgs.clang-tools}/bin/clangd";
        config = {
          fallbackFlags = [ "-std=c23" ];
        };
      };
      nil = {
        config = {
          nil = {
            formatting.command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
          };
        };
      };
    };
    use-grammars = {
      only = [
        "asm"
        "bash"
        "c"
        "cpp"
        "dockerfile"
        "gitconfig"
        "html"
        "ini"
        "java"
        "javascript"
        "json"
        "asm"
        "disassembly"
        "just"
        "cmake"
        "make"
        "kdl"
        "lua"
        "markdown"
        "nasm"
        "nix"
        "python"
        "regex"
        "rust"
        "sql"
        "toml"
        "typescript"
        "x86asm"
        "yaml"
        "zig"
      ];
    };

  };
}
