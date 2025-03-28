{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "hey";
        meta.description = "The default development shell for my NixOS configuration";

        packages = with pkgs; [
          nh
          nil
          nixd
          nixfmt-rfc-style
          statix
          deadnix
          just
        ];
      };
    };
}
