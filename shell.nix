{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "hey";
        meta.description = "The default development shell for my NixOS configuration";
        packages = [
          pkgs.statix
          pkgs.deadnix
        ];
      };
    };
}
