{
  services.mako = {
    enable = true;

    extraConfig = ''
      layer=top
      markup=1
      anchor=top-right
      background-color=#1E1E28
      text-color=#DADAE8
      width=450
      height=200
      max-icon-size=96
      icon-location=right
      margin=20,20,0
      padding=15,15,15
      border-size=2
      border-color=#a4b9ef
      border-radius=15
      progress-color=over #332E41
      default-timeout=2000
      group-by=summary
      format=<span font="JetBrainsMono Nerd Font weight=325 Italic" size="12288">%s</span>\n<span font="OperatorMonoSSm Nerd Font weight=325" size="12288">%b</span>

      [grouped]
      format=<span font="JetBrainsMono Nerd Font weight=325 Italic" size="12288">%s</span>\n<span font="OperatorMonoSSm Nerd Font weight=325" size="12288">%b</span>

      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
