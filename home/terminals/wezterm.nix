{ pkgs, ... }:
{

  home.packages = [
    (pkgs.writers.writeDashBin "wezterm" ''
      export LD_LIBRARY_PATH="/nix/store/x065k38b008bgk3lw6qbzcs5bwdc8y39-xcb-util-image-0.4.1/lib:/nix/store/d6gvgzzifggrb7fh1v0yi8bvrdlwhpqa-libglvnd-1.7.0/lib:/nix/store/k1xq1xkq4sg9p7qrbf4z7y6n78bkrpak-vulkan-loader-1.3.283.0/lib:$LD_LIBRARY_PATH"

      export PATH="/nix/store/bhwf3y25w89xsqqkhg9bplqs6vm59l4x-ncurses-6.4.20221231-dev/bin:/nix/store/a1370wggay4293caa9z82dc5dazmyg5a-ncurses-6.4.20221231/bin:/nix/store/d7gxj7i9zr04mgf819k34vm5dzxgxjzn-pkg-config-wrapper-0.29.2/bin:/nix/store/z7xxy35k7620hs6fn6la5fg2lgklv72l-python3-3.12.4/bin:/nix/store/8xlap0wx88ffq890hdrw5129ixff8h6g-sccache-0.8.1/bin:/nix/store/4y7pvmj6xn54imh0agcpy1kj9fx798l7-mold-wrapper-2.32.1/bin:/nix/store/46n1qljc0drdz4r2k9smxxb8kl79di25-mold-2.32.1/bin:/nix/store/qdrb3l3858yywwvqyq3r67jivklc15nl-glibc-2.39-52-bin/bin:$PATH"


      /home/wasd/dev/wezterm/target/release/wezterm-gui
    '')
  ];

}
