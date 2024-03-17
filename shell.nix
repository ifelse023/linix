{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      name = "linix";
      meta.description = "The default development shell for my NixOS configuration";

      # packages available in the dev shell
      packages = with pkgs; [
        nh
        nil # nix ls
        alejandra # nix formatter
        git # flakes require git, and so do I
        statix # lints and suggestions
        deadnix # clean up unused nix code
      ];
    };
  };
}
