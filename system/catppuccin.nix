{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    grub.enable = false;
    forgejo.enable = false;
    gitea.enable = false;
  };
}
