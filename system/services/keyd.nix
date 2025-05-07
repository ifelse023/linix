{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "esc";
            "102nd" = "*";
          };
          shift = {
            "102nd" = "&";
          };
        };
      };
    };
  };
}
