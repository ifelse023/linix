{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "hey";
        meta.description = "The default development shell for my NixOS configuration";

        packages = with pkgs; [
          nh
          cachix
          nil # nix ls
          nixfmt-rfc-style
          nixd
          statix # lints and suggestions
          deadnix # clean up unused nix code
          just
        ];
      };
    };
}
