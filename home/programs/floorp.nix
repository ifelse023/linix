{
  programs.firefox = {
    enable = true;
    policies = {
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      DisableAppUpdate = true;
    };
    profiles.default = {
      settings = {
        "browser.aboutConfig.showWarning" = false;
      };
  };

  };

    services.psd = {
      enable = true;
      resyncTimer = "10m";
    };

  }

