{ pkgs, ... }: {
  #to save prefs
  programs.xfconf = {
    enable = true;
  };

  programs.thunar = {
    enable = true;

    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}