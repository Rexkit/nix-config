{
  services.mako = {
    enable = true;

    defaultTimeout = 5000;
    actions = true;
    markup = true;
    anchor = "top-right";
    backgroundColor = "#1E1E2E";
    borderColor = "#28283d";
    textColor = "#CDD6F4";
    borderRadius = 12;
    borderSize = 4;
    font = "JetBrains Mono 10";
    width = 300;
    height = 100;
    margin = 20;
    padding = 15;
    icons = true;
    maxIconSize = 48;
    layer = "overlay";
    maxVisible = 5;
    sort = "-time";

    extraConfig = ''
      history=1
      max-history=100
      text-alignment=left
      icon-location=left
      on-button-left=dismiss
      on-button-middle=none
      on-button-right=dismiss-all
      on-touch=dismiss

      [urgency=low]
      border-color=#28283d
      default-timeout=2000

      [urgency=normal]
      border-color=#28283d
      default-timeout=5000

      [urgency=high]
      border-color=#F38BA8
      text-color=#F38BA8
      default-timeout=0
    '';
  };
}