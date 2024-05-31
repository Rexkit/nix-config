{ pkgs, lib, config, hostname, ... }:
{
  home.file."${config.xdg.configHome}/rofi" = {
    source = ../.. + "/common" + /rofi;
    recursive = true;
  };

  home.file."${config.xdg.configHome}/networkmanager-dmenu" = {
    source = ../.. + "/common" + /networkmanager-dmenu;
    recursive = false;
  };

  home.file."$XDG_DATA_HOME/fonts" = {
    source = ../.. + "/common" + /fonts;
    recursive = true;
  };

  # home.file."${config.xdg.configHome}/" = {
  #   source = ../../.. + "/${hostname}" + /;
  #   recursive = true;
  # };
}