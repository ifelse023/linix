{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "linix";
        meta.description = "The default development shell for my NixOS configuration";

        packages = with pkgs; [
          nh
          nil # nix ls
          nixfmt-rfc-style
          statix # lints and suggestions
          deadnix # clean up unused nix code
        ];
      };
    };
}
